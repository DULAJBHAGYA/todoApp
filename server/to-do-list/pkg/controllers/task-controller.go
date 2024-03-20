package controllers

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strconv"
	"strings"
	"to-do-list/pkg/models"
	"to-do-list/pkg/utils"

	"github.com/dgrijalva/jwt-go"

	"github.com/gorilla/mux"
)

// creates a new task for a user
func CreateTask(w http.ResponseWriter, r *http.Request) {
	// Extract the token from the request headers
	tokenHeader := r.Header.Get("Authorization")
	if tokenHeader == "" {
		w.WriteHeader(http.StatusUnauthorized)
		fmt.Fprint(w, "Missing authorization header")
		return
	}
	tokenString := strings.Replace(tokenHeader, "Bearer ", "", 1)

	// Verify the token and extract the username
	username, err := verifyToken(tokenString)
	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		fmt.Fprintf(w, "Invalid token: %v", err)
		return
	}

	// Parse the task from the request body
	task := &models.Task{}
	utils.ParseBody(r, task)

	// Set the username of the task to the extracted username
	task.UserName = username

	// Create the task for the user
	createdTask := models.CreateTask(*task)

	// Marshal the created task into JSON
	res, _ := json.Marshal(createdTask)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	w.Write(res)
}

// retrieves all tasks for the user associated with the provided token
func GetTasks(w http.ResponseWriter, r *http.Request) {

	tokenHeader := r.Header.Get("Authorization")
	if tokenHeader == "" {
		w.WriteHeader(http.StatusUnauthorized)
		return
	}

	tokenString := strings.Replace(tokenHeader, "Bearer ", "", 1)

	username, err := verifyToken(tokenString)
	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		fmt.Fprintf(w, "Invalid token: %v", err)
		return
	}

	tasks := models.GetTasks(username)

	res, err := json.Marshal(tasks)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

// deletes a task for a user
func DeleteTask(w http.ResponseWriter, r *http.Request) {
    // Extract task ID from request parameters
    vars := mux.Vars(r)
    taskID := vars["taskID"]

    // Extract the username from the token
    username, err := utils.GetUsernameFromToken(r)
    if err != nil {
        // Handle error
        http.Error(w, "Unauthorized", http.StatusUnauthorized)
        return
    }

    // Call the delete task function with the task ID
    success := models.DeleteTask(username, taskID)

<<<<<<< Updated upstream
    if success {
        w.WriteHeader(http.StatusOK)
        return
    } else {
        w.WriteHeader(http.StatusNotFound)
        return
    }
=======
	vars := mux.Vars(r)
	taskID := vars["taskID"]

	if !models.DeleteTask(username, taskID) {
		w.WriteHeader(http.StatusNotFound)
		return
	}

	w.WriteHeader(http.StatusOK)
>>>>>>> Stashed changes
}


// updates a task for a user
func UpdateTask(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	taskID := vars["taskID"]

	tokenHeader := r.Header.Get("Authorization")
	if tokenHeader == "" {
		w.WriteHeader(http.StatusUnauthorized)
		return
	}
	tokenString := strings.Replace(tokenHeader, "Bearer ", "", 1)

	username, err := verifyToken(tokenString)
	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		fmt.Fprintf(w, "Invalid token: %v", err)
		return
	}

	// Retrieve all tasks for the user
	tasks := models.GetTasks(username)

	// Find the task with the provided taskID
	var taskToUpdate *models.Task
	for _, task := range tasks {
		if strconv.Itoa(int(task.ID)) == taskID {
			taskToUpdate = &task
			break
		}
	}

	// Check if the task exists and belongs to the user
	if taskToUpdate == nil {
		w.WriteHeader(http.StatusNotFound)
		return
	}

	// Parse the updated task from the request body
	updatedTask := &models.Task{}
	utils.ParseBody(r, updatedTask)

	// Update the task
	if models.UpdateTask(username, taskID, *updatedTask) == nil {
		w.WriteHeader(http.StatusNotFound)
		return
	}

	w.WriteHeader(http.StatusOK)
}

// parses the JWT token and returns its claims
func ParseToken(tokenString string) (jwt.MapClaims, error) {
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		return []byte("secretkey"), nil
	})
	if err != nil {
		return nil, err
	}

	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok || !token.Valid {
		return nil, errors.New("invalid token")
	}

	return claims, nil
}
