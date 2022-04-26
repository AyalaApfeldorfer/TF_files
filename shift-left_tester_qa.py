import datetime
import os
import time

import requests
import json

port = 0
# access_key = input("Enter your accessKeyId:")
access_key = 'NKOMA633XJX5JBE5CYZFZZL5'
# secret_key = input("Enter your secretKey:")
secret_key = '96dBFr67H+VACCu/P50a+o7/6JZsvpezxFqxnvt9'
# file_path = input("Enter the file path(e.g. ~/Desktop/xyz.zip):")
file_path = '~/Desktop/FilesForShiftLeft/read_B_manage_A.tf.zip'
# env = input("Enter your working environment(local/dev/qa):")
env = 'qa'
if env != 'local' and env != 'dev' and env != 'qa':
    print("Wrong environment, please type 'local' or 'dev' or 'qa'. Exit program")
    exit(1)
# scan_name = input("Enter scan name:")
scan_name = 'test_' + str(datetime.datetime.now())
# scan_type = input("Enter scan type (e.g. 'GitHub'):")
scan_type = 'GitHub'
# hi = input("Enter Failure Criteria (high) integer:")
hi = 1
# medium = input("Enter Failure Criteria (medium) integer:")
medium = 3
# low = input("Enter Failure Criteria (low) integer:")
low = 3
# template_type = input("Enter Template Type (e.g. 'tf'):")
template_type = 'tf'
# template_version = input("Enter Template Version (e.g. '0.13'):")
template_version = 0.13

# Authentication #
if env == 'local':
    port = input("Enter your port:")
    url = f"http://localhost:{port}/api/v1/accesskeys/authentication"
else:
    url = f"https://api.us-east-1.{env}-cwp.seculert.com/api/v1/accesskeys/authentication"

payload = json.dumps({
    "accessKeyId": access_key,
    "secretKey": secret_key
})
headers = {
    'Content-Type': 'application/json'
}

token = requests.request("POST", url, headers=headers, data=payload)

print("Bearer token:\n" + token.text)

# Create scan #
if env == 'local':
    url = f"http://localhost:{port}/api/v1/shiftLeft/scans"
else:
    url = f"https://api.us-east-1.{env}-cwp.seculert.com/api/v1/shiftLeft/scans"

payload = json.dumps({
    "scanName": scan_name,
    "type": scan_type,
    "failureCriteria": {
        "high": hi,
        "medium": medium,
        "low": low
    },
    "templateInformation": {
        "templateType": template_type,
        "templateVersion": template_version
    }
})
headers = {
    'Authorization': 'Bearer ' + token.text,
    'Content-Type': 'application/json'
}

response = requests.request("POST", url, headers=headers, data=payload)

responseJson = json.loads(response.text)
presignedUrl = responseJson.get("presignedUrl")
scanId = responseJson.get("scanId")

print("\nCreate scan response:\n" + json.dumps(json.loads(response.text), indent=4, sort_keys=True))

# Upload Scan file #
print("\nUpload file to S3:\n")
cmd = f"""curl -v -X PUT '{presignedUrl}' -T {file_path}"""
os.system(cmd)

# Start scan #
if env == 'local':
    url = f"http://localhost:{port}/api/v1/shiftLeft/scans/scanRequest?scanId=" + scanId
else:
    url = f"https://api.us-east-1.{env}-cwp.seculert.com/api/v1/shiftLeft/scans/scanRequest?scanId=" + scanId

payload = {}
headers = {
    'Authorization': 'Bearer ' + token.text,
}

response = requests.request("POST", url, headers=headers, data=payload)

print("\nScan started\n" + response.text)

time.sleep(10)

# Get scan results #
if env == 'local':
    url = f"http://localhost:{port}/api/v1/shiftLeft/scans/" + scanId
else:
    url = f"https://api.us-east-1.{env}-cwp.seculert.com/api/v1/shiftLeft/scans/" + scanId

payload = {}
headers = {
    'Authorization': 'Bearer ' + token.text,
}

response = requests.request("GET", url, headers=headers, data=payload)

print("\nGet scan status by id:" + scanId + "\n" + json.dumps(json.loads(response.text), indent=4, sort_keys=True))
