package model

type JobInfo struct {
	Name  string `json:"name"`
	URL   string `json:"url"`
}

type Jobs struct {
	Jobs  []JobInfo `json:"jobs"`
}

type RolePermissions struct {
	Description        string   `json:"description"`
	Filterable         bool     `json:"filterable"`
	GrantedPermissions []string `json:"grantedPermissions"`
	ID                 string   `json:"id"`
}
