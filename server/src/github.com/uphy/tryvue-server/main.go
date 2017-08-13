package main

import (
	"fmt"
	"net/url"
	"os"

	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
)

func main() {
	e := echo.New()
	e.Debug = os.Getenv("MODE") != "production"
	if e.Debug {
		fmt.Println("Enabled Debug mode")
	}

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	if e.Debug {
		backend, _ := url.Parse("http://localhost:8081/")
		p := middleware.Proxy(&middleware.RoundRobinBalancer{
			Targets: []*middleware.ProxyTarget{
				&middleware.ProxyTarget{
					URL: backend,
				},
			},
		})
		e.Group("/").Use(p)
	} else {
		e.Static("/public", "./public") // resources such as images
		e.Static("/dist", "./dist")     // js
		e.Static("/", "./static")       // index.html
	}

	e.GET("/api/test", func(context echo.Context) error {
		return context.JSON(200, map[string]interface{}{
			"a": 100,
		})
	})

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	err := e.Start(fmt.Sprintf(":%s", port))
	fmt.Println(err)
}
