---
title: "Running Python on Aws Lambda"
date: 2017-10-28T15:49:35Z
draft: false
---

The idea of "serverless" fascinates me since I first heard it. Write some code, deploy and voila, your code is globally available. I awaited a chance for get my feet wet and last week I got. In [Artistanbul](https://www.artistanbul.io) we were toying with the idea to create a Facebook Messenger chatbot for one of our clients. Chatbots are perfect for going serverless, so I volunteered for creating a prototype.

This post is not a tutorial for creating a Facebook Messenger chatbot. I'm writing this just for logging purposes, So I can come back in the future and restart my serverless journey wherever I left.

Lambda looks for `handler` function to execute your code. Create a handler function and deploy it for testing.

```python
def handler(event, context):
    return {
        'message': f'Hello {event["name"]}'
    }
```

For deployment you need to create a zip file containing your dependencies and code. For learning purposes I did deployment manually, but you should really checkout [Zappa](https://github.com/Miserlou/Zappa).

```sh
$ zip lambda.zip lambda.py
```

Create the execution role by following the steps described [here](http://docs.aws.amazon.com/lambda/latest/dg/with-s3-example-create-iam-role.html). Copy role ARN to anywhere accessible.

Get root's access key id and secret key from [IAM Management Console](https://console.aws.amazon.com/iam/). Note that using root user's access keys is against Amazon's recommendation and promise yourself that you will not do this any serious project.

Add security credentials. This will create a directory named `.aws` and two files: `config` and `credentials`.

```sh
$ aws configure
AWS Access Key ID [None]: ACCESS_KEY_ID
AWS Secret Access Key [None]: SECRET_ACCESS_KEY
Default region name [None]: eu-central-1
Default output format [None]: json
```

Create the function by:

```sh
$ aws lambda create-function \
    --region eu-central-1 \
    --function-name lambda \
    --zip-file fileb://lambda.zip \
    --role your-role-arn \
    --handler lambda.handler \
    --runtime python3.6 \
    --profile default \
    --timeout 10 \
    --memory-size 1024
```

To invoke the function create an event template...

```json
{
    "name": "Ege"
}
```

and invoke from cli:

```sh
$ aws lambda invoke \
    --invocation-type RequestResponse \
    --function-name lambda \
    --payload file://test.json \
    output
{
    "StatusCode": 200
}
```

Note that there are two invocation types of lambda functions: `Event` (asynchronous execution) and `RequestResponse` (synchronous execution). If you use `Event` invocation type the return value of `handler` will be discarded.

```sh
$ cat output
{"message": "Hello Ege"}
```
