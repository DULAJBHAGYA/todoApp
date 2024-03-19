package utils

import (
    "errors"
    "net/http"
    "strings"

    "github.com/dgrijalva/jwt-go"
)

// getUsernameFromToken extracts the username from the JWT token
func GetUsernameFromToken(r *http.Request) (string, error) {
    // Extract the token from the request headers
    tokenHeader := r.Header.Get("Authorization")
    if tokenHeader == "" {
        return "", errors.New("missing authorization header")
    }
    tokenString := strings.Replace(tokenHeader, "Bearer ", "", 1)

    // Parse the JWT token
    token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
        return []byte("your-secret-key"), nil // Replace "your-secret-key" with your actual secret key
    })
    if err != nil {
        return "", err
    }

    // Extract the username from the token claims
    claims, ok := token.Claims.(jwt.MapClaims)
    if !ok || !token.Valid {
        return "", errors.New("invalid token")
    }

    username := claims["username"].(string)
    return username, nil
}
