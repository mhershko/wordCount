[
   {
      "essential": true,
      "name":"words-count-app",
      "image":"${REPOSITORY_URL}",
      "portMappings":[
         {
            "containerPort":5000,
            "hostPort":5000,
            "protocol":"tcp"
         }
      ],
      "environment":[
         {
            "name":"FLASK_APP",
            "value":"${FLASK_APP}"
         },
         {
            "name":"APP_HOME",
            "value":"${FLASK_APP_HOME}"
         },
         {
            "name":"APP_PORT",
            "value":"${FLASK_APP_PORT}"
         }
      ]
   }
]