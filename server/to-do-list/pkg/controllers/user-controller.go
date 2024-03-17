// user_controller.go

package controllers

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strconv"
	"time"
	"to-do-list/pkg/models"
	"to-do-list/pkg/utils"

	"github.com/dgrijalva/jwt-go"
	"github.com/gorilla/mux"
	"golang.org/x/crypto/bcrypt"
)

var secretKey = []byte("secret-key")

// registers a new user
func RegisterUser(w http.ResponseWriter, r *http.Request) {
	user := &models.User{}
	utils.ParseBody(r, user)

	//check if user is already registered using email address
	existingUser := models.GetUserByEmail(user.Email)
	if existingUser != nil {
		http.Error(w, "You have already registered..", http.StatusConflict)
		return
	}

	// Check if password matches confirmed password
	if user.Password != user.ConfirmedPassword {
		// If passwords don't match, return a 400 Bad Request response
		http.Error(w, "Passwords do not match", http.StatusBadRequest)
		return
	}

	// Hash the password before creating the user
	user.Password = utils.GetHash([]byte(user.Password))
	user.ConfirmedPassword = utils.GetHash([]byte(user.ConfirmedPassword))

	createdUser := user.CreateUser()
	res, err := json.Marshal(createdUser)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	w.Write(res)
}

// logs as an existing user
func LoginUser(w http.ResponseWriter, r *http.Request) {

	credentials := &models.LoginCredentials{} // Parse login credentials from request body
	utils.ParseBody(r, credentials)

	fmt.Println("Attempting login with username:", credentials.Username) // Log the username

	hashedPassword := utils.GetHash([]byte(credentials.Password)) // Hash the password provided by the user

	// Retrieve the user from the database by username
	user := models.GetUserByUsername(credentials.Username)
	if user == nil {
		w.WriteHeader(http.StatusUnauthorized) // User not found
		return
	}

	// Compare hashed passwords
	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(hashedPassword)); err != nil {
		// Password incorrect
		w.WriteHeader(http.StatusUnauthorized)
		return
	}

	// Generate token after successful login
	tokenString, err := generateToken(user.Username)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		fmt.Fprintf(w, "Error creating token: %v", err)
		return
	}

	// Construct response with token
	response := struct {
		Token string `json:"token"`
	}{
		Token: tokenString,
	}

	// Marshal response to JSON
	res, err := json.Marshal(response)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		fmt.Fprintf(w, "Error marshalling response: %v", err)
		return
	}

	// Set response headers and write response
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func generateToken(username string) (string, error) {
	// Generate JWT token
	token := jwt.NewWithClaims(jwt.SigningMethodHS256,
		jwt.MapClaims{
			"username": username,
			"exp":      time.Now().Add(time.Minute * 1).Unix(),
		})

	tokenString, err := token.SignedString(secretKey)
	if err != nil {
		return "", err
	}

	return tokenString, nil
}

func verifyToken(tokenString string) (string, error) {
	// Verify JWT token
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		return secretKey, nil
	})

	if err != nil {
		return "", err
	}

	if !token.Valid {
		return "", fmt.Errorf("invalid token")
	}

	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		return "", fmt.Errorf("invalid claims")
	}

	username, ok := claims["username"].(string)
	if !ok {
		return "", errors.New("invalid username claim")
	}
	return username, nil
}

// updates a user
func UpdateUser(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	userID := vars["userID"]
	_, err := strconv.ParseUint(userID, 10, 64)
	if err != nil {
		fmt.Println("error while parsing user ID:", err)
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	user := models.GetUserByUsername(userID)
	if user == nil {
		w.WriteHeader(http.StatusNotFound)
		return
	}

	userData := &models.User{}
	utils.ParseBody(r, userData)

	user.Name = userData.Name
	user.Email = userData.Email
	user.Username = userData.Username
	user.Password = utils.GetHash([]byte(userData.Password)) // Hash the updated password
	user.ConfirmedPassword = utils.GetHash([]byte(userData.ConfirmedPassword))

	updatedUser := user.UpdateUser()
	res, _ := json.Marshal(updatedUser)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

// deletes a user
func DeleteUser(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	userID := vars["userID"]
	ID, err := strconv.ParseUint(userID, 10, 64)
	if err != nil {
		fmt.Println("error while parsing user ID:", err)
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	models.DeleteUser(uint(ID))
	w.WriteHeader(http.StatusNoContent)
}

// retrieves a user by username
func GetUserByUsername(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	username := vars["username"]

	user := models.GetUserByUsername(username) // Retrieve the user from the database

	if user == nil {
		w.WriteHeader(http.StatusNotFound)
		return
	}

	res, err := json.Marshal(user) // Convert the user to JSON format
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json") // write the json response
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func GetUserByEmail(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	email := vars["email"]

	user := models.GetUserByEmail(email) // Retrieve the user from the database

	if user == nil {
		w.WriteHeader(http.StatusNotFound)
		return
	}

	res, err := json.Marshal(user) // Convert the user to JSON format
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json") // write the json response
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}
