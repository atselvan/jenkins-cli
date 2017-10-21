package backend

import (
	"net/http"
	"fmt"
	"io/ioutil"
)

func httpRequest(url string, method string, username string, password string, verbose bool) []byte {

	client := &http.Client{}
	req, err := http.NewRequest(method, url, nil)
	req.SetBasicAuth(username, password)
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Accept", "application/json")
	resp, err := client.Do(req)
	if err != nil {
		fmt.Println(err)
	}
	defer resp.Body.Close()
	responseBody, err := ioutil.ReadAll(resp.Body)

	//Print verbose logs if verbose flag is set
	if verbose {
		fmt.Println("Request Url:", req.URL)
		fmt.Println("Request Headers:", req.Header)
		fmt.Println("Response Headers:", resp.Header)
		fmt.Println("Response Status:", resp.Status)
		fmt.Println("Response Body:", string(responseBody))
	}

	switch resp.Status {
	case "200 OK":
		fmt.Printf("Success: OK\n")
	case "401 Invalid password/token for user: " + username:
		panic(fmt.Sprintf("ERROR: Password is incorrect\n"))
	default:
		panic(fmt.Sprintf("ERROR: call status=%v\n", resp.Status))
	}

	return responseBody
}
