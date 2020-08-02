## Example production workflow

This is an example production workflow from a Udemy course about deploying Docker applications with Kubernetes.

### Start the development server

```zsh
docker-compose up
```

### Run tests while developing

Start the development server using the above command. In a second terminal window, `cd` into the same path, then:

```zsh
docker-compose exec frontend npm run test
```

### Try the production server locally

```zsh
docker build .
docker run -p 8080:80 <image id>
```
