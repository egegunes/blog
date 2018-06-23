---
title: "Working With Panopto Api Using Zeep"
date: 2018-06-16T15:48:50Z
draft: false
---

[Panopto](www.panopto.com) is a video recording and publishing platform specifically targeted for education. Recently I had to work with their API and had some trouble with it. It’s only fair if I say their documentation is not good. There are some examples from [Graham’s blog](http://www.mediaguy.co.uk/panopto-api), but they are for C# mostly. I interacted with their support team several times and they were always friendly and helpful. So, I wanted to write a post to help people to use Panopto API using Python.

## SOAP

Panopto’s API is using [SOAP](https://en.wikipedia.org/wiki/SOAP). I’ve only worked with RESTful API’s before and SOAP seemed a little odd at first. It’s XML schemes, completely different endpoint logic from REST APIs really confused me. But SOAP has its advantages. The best feature of SOAP is its self documentation. You make a request to a SOAP endpoint and it dumps all actions you can use with the required parameters.

## Zeep

After a quick research I learnt [Zeep](https://github.com/mvantellingen/python-zeep) is go-to SOAP client in Python ecosystem.

```
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install zeep
```

## Examples

To use the API, we need a Panopto user with admin privileges. All requests to the API must contain the username and password.

### Create a folder

```
from zeep import Client

AUTH = {
    “UserKey”: “username”,
    “Password”: “password”
}

client = Client(“https://<PANOPTO_SERVER>/Panopto/PublicAPI/4.2/SessionManagement.svc?wsdl”)
client.service.AddFolder(auth=AUTH, name=“myfolder”, parentFolder=“<FOLDER_GUID>”)
```

### Grant access to folder

```
client = Client(“https://<PANOPTO_SERVER>/Panopto/PublicApi/4.2/AccessManagement.svc?wsdl”)
client.service.GrantUsersAccessToFolder(auth=AUTH, folderId=“<FOLDER_GUID>”, userIds=[“<USER_GUID”], role=“Viewer”)
```

### Revoke access from folder

```
client = Client(“https://<PANOPTO_SERVER>/Panopto/PublicApi/4.2/AccessManagement.svc?wsdl”)
client.service.RevokeUsersAccessFromFolder(auth=AUTH, folderId=“<FOLDER_GUID>”, userIds=[“<USER_GUID>”], role=“Viewer”)
```

### More

Panopto API has five endpoints:

1. AccessManagement
2. SessionManagement
3. RemoteRecorderManagement
4. UsageReporting
5. UserManagement

You can see all services provided by endpoint like this:

```
client = Client(“https://<PANOPTO_SERVER>/Panopto/PublicApi/4.2/<ENDPOINT>.svc?wsdl”)
client.wsdl.dump()
```

Additionally, Panopto has a [Github profile](https://github.com/panopto) and they have a great deal of open sourced integrations with various learning management systems. You can have a look in there for more complete examples.

