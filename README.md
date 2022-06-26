# highintensivejobsawslambda
Sample of AWS lambda usage

Build:

```
docker-compose build
```

Start:
```
docker-compose up
```

Send a message to the simple lambda (just logs)
```
aws sqs send-message --endpoint-url=http://localhost:4566 --queue-url http://localhost:4576/000000000000/testQueue --region us-east-1 --message-body 'Test Message!'
```
