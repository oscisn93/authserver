-- name: GetUser :one
SELECT * FROM user
WHERE uuid = ? LIMIT 1;

-- name: ListUsers :many
SELECT * FROM user
ORDER BY username;

-- name: CreateUser :one
INSERT INTO user (
  uuid,
  username,
  email,
  password_hash
) VALUES (
  ?, ?, ?, ?
) RETURNING;

-- name: UpdateUser: exec
UPDATE user
SET given_name = ?,
family_name = ?,
update_at = ?
WHERE uuid = ?;

-- name: DeleteUser :exec
DELETE FROM user
WHERE uuid = ?;

