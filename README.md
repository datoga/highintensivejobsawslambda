# Resource intensive jobs: when AWS lambda performs too well  [![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://github.com/datoga/highintensivejobsawslambda)

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

Sends a message to screenshots lambda (take a photo of a website)

```
aws sqs send-message --endpoint-url=http://localhost:4566 --queue-url http://localhost:4576/000000000000/screenshotsQueue --region us-east-1 --message-body 'https%3A%2F%2Fwww.booking.com%2Fhotel%2Fes%2Fcondado.es.html%3Faid%3D356980%26label%3Dgog235jc-1DCAsoRkIHY29uZGFkb0gKWANoRogBAZgBCrgBB8gBDNgBA-gBAfgBAogCAagCA7gCiIznlQbAAgHSAiQzZjUwOTI5Mi05NzcyLTQwZGItODViMC0zMjE0M2M5NWQ4MmLYAgTgAgE%26sid%3D38a79f2abebd1c881e599527a0e7c36b%26all_sr_blocks%3D9040002_353967785_0_2_0%3Bcheckin%3D2022-12-01%3Bcheckout%3D2022-12-02%3Bdest_id%3D-372490%3Bdest_type%3Dcity%3Bdist%3D0%3Bgroup_adults%3D2%3Bgroup_children%3D0%3Bhapos%3D1%3Bhighlighted_blocks%3D9040002_353967785_0_2_0%3Bhpos%3D1%3Bmatching_block_id%3D9040002_353967785_0_2_0%3Bno_rooms%3D1%3Breq_adults%3D2%3Breq_children%3D0%3Broom1%3DA%252CA%3Bsb_price_type%3Dtotal%3Bsr_order%3Dpopularity%3Bsr_pri_blocks%3D9040002_353967785_0_2_0__8106%3Bsrepoch%3D1656342047%3Bsrpvid%3D00bd698feb5e02a9%3Btype%3Dtotal%3Bucfs%3D1%26%23hotelTmpl'
```
