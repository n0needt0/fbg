#REST API Version 0.1


| Get all folders in the root |   |
|-----------------------------|---|
| URL                         |/v1/docs?{“token”:ID}|
| Method                      |GET|
| URL Parameters              |<ul><li><strong>Required:</strong> None</li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong> None</li><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</ul></li></li></ul>|
| Success Response            |<ul><li>Content: {error:””, data:[“f1”:{“name”:”NAME”,"nfiles":NUM_FILES},“f2”:{“name”:”NAME”,"nfiles":NUM_FILES}]}</li><li>For any number of folders.</li><li></li>Valid response codes:<ul><li>200 OK</li><li>204 No content</li><li>301, 302, 303 Redirect to correct content</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>404 Not found</li><li>405 Method not found</li><li>408 Timeout</li><li>410 Gone</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/?{“token”:3861739164332}”, dataType:"json", type:"GET",sucess:function(r){console.log(r);}});|

| Remove folder from root     |   |
|-----------------------------|---|
| URL                         |/v1/docs?{“token”:ID,"fname":"FILE_NAME"}|
| Method                      |DELETE|
| URL Parameters              |<ul><li><strong>Required:</strong> None</li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>fname: Specifies the file to be deleted</li></ul><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>204 No content to be deleted</li><li>301, 302, 303 Redirect to correct content to be deleted</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>404 Not found</li><li>405 Method not found</li><li>408 Timeout</li><li>410 Gone</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/?{“token”:3861739164332}”,"fname":"Folder3", dataType:"json", type:"DELETE",sucess:function(r){console.log(r);}});|

| Add folder to root          |   |
|-----------------------------|---|
| URL                         |/v1/docs?{“token”:ID,"fname":"FILE_NAME"}|
| Method                      |POST|
| URL Parameters              |<ul><li><strong>Required:</strong> None</li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>fname: Specifies the file to be created</li></ul><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>201 Folder created</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>405 Method not found</li><li>408 Timeout</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/?{“token”:3861739164332}”,"fname":"Folder3", dataType:"json", type:"POST",sucess:function(r){console.log(r);}});|
