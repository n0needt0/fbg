#REST API Version 0.1

##Table of Contents

+ [Root Commands](#root-commands)
 - [Get all folders in the root](#get-all-folders-in-the-root)
 - [Remove folder from root](#remove-folder-from-root)
 - [Add folder to root](#add-folder-to-root)
+ [Folder and File Commands](#folder-and-file-commands)
 - [Search for tab](#search-for-tab)
 - [Create new tab](#create-new-tab)
+ [Folder Commands](#folder-commands)
 - [Get all files in a folder](#get-all-files-in-a-folder)
 - [Remove file from folder](#remove-file-from-folder)
 - [Add global tab](#add-global-tab)
 - [Edit global tab](#edit-global-tab)
 - [Delete global tab](#delete-global-tab)
 - [Edit global property](#edit-global-property)
+ [File Commands](#file-commands)
 - [Get file data](#get-file-data)
 - [Add tab](#add-tab)
 - [Edit tab](#edit-tab)
 - [Delete tab](#delete-tab)
 - [Edit property](#edit-property)

##Root Commands

| <a name="get-all-folders-in-the-root"></a>Get all folders in the root |   |
|-----------------------------|---|
| URL                         |/v1/docs?{“token”:ID}|
| Method                      |GET|
| URL Parameters              |<ul><li><strong>Required:</strong> None</li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong> None</li><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</ul></li></li></ul>|
| Success Response            |<ul><li>Content: {error:””, data:[“f1”:{“name”:”NAME”,"nfiles":NUM_FILES},“f2”:{“name”:”NAME”,"nfiles":NUM_FILES}]}</li><li>For any number of folders.</li><li></li>Valid response codes:<ul><li>200 OK</li><li>204 No content</li><li>301, 302, 303 Redirect to correct content</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>404 Not found</li><li>405 Method not found</li><li>408 Timeout</li><li>410 Gone</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/?{“token”:3861739164332}, dataType:"json", type:"GET",success:function(r){console.log(r);}});|

| <a name="remove-folder-from-root"></a>Remove folder from root     |   |
|-----------------------------|---|
| URL                         |/v1/docs?{“token”:ID,"fname":"FOLDER_NAME"}|
| Method                      |DELETE|
| URL Parameters              |<ul><li><strong>Required:</strong> None</li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>fname: Specifies the folder to be deleted</li></ul><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>204 No content to be deleted</li><li>301, 302, 303 Redirect to correct content to be deleted</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>404 Not found</li><li>405 Method not found</li><li>408 Timeout</li><li>410 Gone</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/?{“token”:3861739164332,"fname":"Folder3"}, dataType:"json", type:"DELETE",success:function(r){console.log(r);}});|

| <a name="add-folder-to-root"></a>Add folder to root          |   |
|-----------------------------|---|
| URL                         |/v1/docs?{“token”:ID,"fname":"FOLDER_NAME"}|
| Method                      |POST|
| URL Parameters              |<ul><li><strong>Required:</strong> None</li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>fname: Specifies the folder to be created</li></ul><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>201 Folder created</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>405 Method not found</li><li>408 Timeout</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/?{“token”:3861739164332,"fname":"Folder3"}, dataType:"json", type:"POST",success:function(r){console.log(r);}});|

***
##Folder and File Commands

| <a name="search-for-tab"></a> Search for tab       |   |
|-----------------------------|---|
| URL                         |/v1/tabs/?{“token”:ID,"name":"NAME_PARTIAL","ssn":SSN_PARTIAL}|
| Method                      |GET|
| URL Parameters              |<ul><li><strong>Required:</strong> None</li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong> None<li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li><li>Partial name to search for.</li><li>Partial SSN to search for.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””,"tabs":["t1":{"name":"NAME_1","ssn":SSN_1},"t2":{"name":"NAME_2","ssn":SSN_2}]}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>204 No content</li><li>301, 302, 303 Redirect to correct content</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>405 Method not found</li><li>408 Timeout</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/tabs/?{“token”:3861739164332”,"name":"John S"}, dataType:"json", type:"GET",success:function(r){console.log(r);}});|

| <a name="create-new-tab"></a>Create new tab      |   |
|-----------------------------|---|
| URL                         |/v1/tabs/?{“token”:ID,"name":"NAME","ssn":SSN}|
| Method                      |POST|
| URL Parameters              |<ul><li><strong>Required:</strong> None</li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>Name to attribute to tab.</li><li>SSN to attribute to tab.</li></ul><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>201 Tab created</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>405 Method not found</li><li>408 Timeout</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/tabs/?{“token”:3861739164332,"name":"John Smith","ssn":1234}, dataType:"json", type:"POST",success:function(r){console.log(r);}});|

***
##Folder Commands

| <a name="get-all-files-in-a-folder"></a>Get all files in a folder |   |
|-----------------------------|---|
| URL                         |/v1/docs/FOLDER_NAME?{“token”:ID,"action":"files"}|
| Method                      |GET|
| URL Parameters              |<ul><li><strong>Required:</strong><ul><li>Folder name required to search for specific files.</li></ul></li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>File action differentiates this request from tab actions.</li></ul></li><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</ul></li></li></ul>|
| Success Response            |<ul><li>Content: {error:””, data:[“f1”:{“name”:”NAME”,"date":DATE_MODIFIED,"last editor":"LAST_EDITOR"},“f2”:{“name”:”NAME”,"date":DATE_MODIFIED,"last editor":"LAST_EDITOR"},}]}</li><li>For any number of files.</li><li></li>Valid response codes:<ul><li>200 OK</li><li>204 No content</li><li>301, 302, 303 Redirect to correct content</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>404 Not found</li><li>405 Method not found</li><li>408 Timeout</li><li>410 Gone</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/mailtoday/?{“token”:3861739164332}, dataType:"json", type:"GET",success:function(r){console.log(r);}});|

| <a name="remove-file-from-folder"></a>Remove file from folder     |   |
|-----------------------------|---|
| URL                         |/v1/docs/FOLDER_NAME?{“token”:ID,"fname":"FILE_NAME","action":"files"}|
| Method                      |DELETE|
| URL Parameters              |<ul><li><strong>Required:</strong><ul><li>Folder name required to search for specific files.</li></ul></li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>fname: Specifies the file to be deleted</li><li>File action differentiates this request from tab actions.</li></ul><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>204 No content to be deleted</li><li>301, 302, 303 Redirect to correct content to be deleted</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>404 Not found</li><li>405 Method not found</li><li>408 Timeout</li><li>410 Gone</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/mailtoday/?{“token”:3861739164332”,"fname":"File3"}, dataType:"json", type:"DELETE",success:function(r){console.log(r);}});|

| <a name="add-global-tab"></a>Add global tab         |   |
|-----------------------------|---|
| URL                         |/v1/docs/FOLDER_NAME?{“token”:ID,"name","TAB_PATIENT_NAME","ssn":LAST_4_DIGITS_SSN,"action":"tabs"}|
| Method                      |POST|
| URL Parameters              |<ul><li><strong>Required:</strong><ul><li>Folder name required to add tag to all files in a specific folder.</li></ul></li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>Name is the patient name.</li><li>SSN is the last 4 digits of the patient's social security number.</li><li>Tab action differentiates this request from file actions.</li></ul><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>201 Tab created</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>405 Method not found</li><li>408 Timeout</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/mailtoday/?{“token”:3861739164332”,"name":"John Smith","ssn":1234}, dataType:"json", type:"POST",success:function(r){console.log(r);}});|

| <a name="edit-global-tab"></a>Edit global tab                      |   |
|-----------------------------|---|
| URL                         |/v1/docs/FOLDER_NAME?{“token”:ID, "oldname":"OLD_TAB_PATIENT_NAME","oldssn":OLD_PATIENT_SSN,"name","TAB_PATIENT_NAME","ssn":LAST_4_DIGITS_SSN,"action":"tabs"}|
| Method                      |PUT|
| URL Parameters              |<ul><li><strong>Required:</strong><ul><li>Folder name required to add tag to all files in a specific folder.</li></ul></li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>The old name identifies the tab to be changed.</li><li>The old ssn further identifies the tab to be changed.</li><li>Tab action differentiates this request from file actions.</li></ul></li><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li><li>The new patient name for the tab is changed from the old one.</li><li>The new patient SSN for the tab is changed from the old one.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>201 Tab changed.</li><li>301, 302, 303 Redirect to correct content</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>404 Not found</li><li>405 Method not found</li><li>408 Timeout</li><li>410 Gone</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/mailtoday/?{“token”:3861739164332”,"oldname":"Johny Smith","oldssn":1233,"name":"John Smith","ssn":1234}, dataType:"json", type:"PUT",success:function(r){console.log(r);}});|

| <a name="delete-global-tab"></a>Delete global tab                      |   |
|-----------------------------|---|
| URL                         |/v1/docs/FOLDER_NAME?{“token”:ID,"name","TAB_PATIENT_NAME","ssn":LAST_4_DIGITS_SSN,"action":"tabs"}|
| Method                      |DELETE|
| URL Parameters              |<ul><li><strong>Required:</strong><ul><li>Folder name required to add tag to all files in a specific folder.</li></ul></li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>The old name identifies the tab to be deleted.</li><li>The old ssn further identifies the tab to be deleted.</li><li>Tab action differentiates this request from file actions.</li></ul><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>204 No content to be deleted</li><li>301, 302, 303 Redirect to correct content to be deleted</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>404 Not found</li><li>405 Method not found</li><li>408 Timeout</li><li>410 Gone</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/mailtoday/?{“token”:3861739164332”,"name":"John Smith","ssn":1234}, dataType:"json", type:"DELETE",success:function(r){console.log(r);}});|

| <a name="edit-global-property"></a>Edit global property                     |   |
|-----------------------------|---|
| URL                         |/v1/docs/FOLDER_NAME?{“token”:ID,"pname":"PROPERTY_NAME","pvalue":"PROPERTY_VALUE","action":"properties"}|
| Method                      |PUT|
| URL Parameters              |<ul><li><strong>Required:</strong><ul><li>Folder name required to edit properties of all files inside folder</li></ul></li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>Property name is the property to be edited.</li><li>Property value is the new property value.</li><li>Property action differentiates this request from file actions and tab actions.</li></ul><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>201 Property changed</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>404 Not found</li><li>405 Method not found</li><li>408 Timeout</li><li>410 Gone</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/mailtoday/?{“token”:3861739164332,"pname":"type","pvalue":"chart","action":"properties"}, dataType:"json", type:"PUT",success:function(r){console.log(r);}});|

***
##File Commands

| <a name="get-file-data"></a>Get file data                     |   |
|-----------------------------|---|
| URL                         |/v1/docs/FOLDER_NAME?{“token”:ID,"fname":"FILE_NAME"}|
| Method                      |DELETE|
| URL Parameters              |<ul><li><strong>Required:</strong><ul><li>Folder name required to search for specific files.</li></ul></li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>fname: Specifies the file to be deleted</li></ul><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>204 No content to be deleted</li><li>301, 302, 303 Redirect to correct content to be deleted</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>404 Not found</li><li>405 Method not found</li><li>408 Timeout</li><li>410 Gone</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/mailtoday/?{“token”:3861739164332}”,"fname":"File3", dataType:"json", type:"DELETE",success:function(r){console.log(r);}});|

| <a name="add-tab"></a>Add tab                      |   |
|-----------------------------|---|
| URL                         |/v1/docs/FOLDER_NAME?{“token”:ID,"fname":"FILE_NAME"}|
| Method                      |DELETE|
| URL Parameters              |<ul><li><strong>Required:</strong><ul><li>Folder name required to search for specific files.</li></ul></li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>fname: Specifies the file to be deleted</li></ul><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>204 No content to be deleted</li><li>301, 302, 303 Redirect to correct content to be deleted</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>404 Not found</li><li>405 Method not found</li><li>408 Timeout</li><li>410 Gone</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/mailtoday/?{“token”:3861739164332}”,"fname":"File3", dataType:"json", type:"DELETE",success:function(r){console.log(r);}});|

| <a name="edit-tab"></a>Edit tab                      |   |
|-----------------------------|---|
| URL                         |/v1/docs/FOLDER_NAME?{“token”:ID,"fname":"FILE_NAME"}|
| Method                      |DELETE|
| URL Parameters              |<ul><li><strong>Required:</strong><ul><li>Folder name required to search for specific files.</li></ul></li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>fname: Specifies the file to be deleted</li></ul><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>204 No content to be deleted</li><li>301, 302, 303 Redirect to correct content to be deleted</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>404 Not found</li><li>405 Method not found</li><li>408 Timeout</li><li>410 Gone</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/mailtoday/?{“token”:3861739164332}”,"fname":"File3", dataType:"json", type:"DELETE",success:function(r){console.log(r);}});|

| <a name="delete-tab"></a>Delete tab                      |   |
|-----------------------------|---|
| URL                         |/v1/docs/FOLDER_NAME?{“token”:ID,"fname":"FILE_NAME"}|
| Method                      |DELETE|
| URL Parameters              |<ul><li><strong>Required:</strong><ul><li>Folder name required to search for specific files.</li></ul></li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>fname: Specifies the file to be deleted</li></ul><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>204 No content to be deleted</li><li>301, 302, 303 Redirect to correct content to be deleted</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>404 Not found</li><li>405 Method not found</li><li>408 Timeout</li><li>410 Gone</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/mailtoday/?{“token”:3861739164332}”,"fname":"File3", dataType:"json", type:"DELETE",success:function(r){console.log(r);}});|

| <a name="edit-property"></a>Edit property                      |   |
|-----------------------------|---|
| URL                         |/v1/docs/FOLDER_NAME?{“token”:ID,"fname":"FILE_NAME"}|
| Method                      |DELETE|
| URL Parameters              |<ul><li><strong>Required:</strong><ul><li>Folder name required to search for specific files.</li></ul></li><li><strong>Optional:</strong> None</li></ul>|
| Data Parameters             |<ul><li><strong>Required:</strong><ul><li>fname: Specifies the file to be deleted</li></ul><li><strong>Optional:</strong><ul><li>Security token for access. If none given, resort to default behavior.</li></ul></li></ul>|
| Success Response            |<ul><li>Content: {error:””}</li><li></li>Valid response codes:<ul><li>200 OK</li><li>204 No content to be deleted</li><li>301, 302, 303 Redirect to correct content to be deleted</li></ul></li></ul>|
| Error Response              |<ul><li>Content: {error:”Error code”}</li><li>Valid response codes:<ul><li>400 Bad request</li><li>401 Unauthorized</li><li>403 Forbidden</li><li>404 Not found</li><li>405 Method not found</li><li>408 Timeout</li><li>410 Gone</li><li>422 Unprocessable entity</li><li>429 Too many requests</li><li>500 Internal server error</li><li>502 Bad gateway</li><li>503 Service unavailable</li></ul></li></ul>|
| Sample Call                 |$.ajax({url: “v1/docs/mailtoday/?{“token”:3861739164332}”,"fname":"File3", dataType:"json", type:"DELETE",success:function(r){console.log(r);}});|