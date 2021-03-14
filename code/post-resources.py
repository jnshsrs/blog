import json
import requests

# Define Baseline Parameter for API POST 
url = "http://hapi.fhir.org/baseR4"
headers = {
  'Content-Type': 'application/json'
}

# Read Patient 
with open('fhir-resources/patient.json') as f:
  patient = json.load(f)

patient = json.dumps(patient)

response = requests.request("POST", url + "Patient", headers=headers, data=patient)

# Get the Patient ID 
patient_id = json.loads(response.text)['id']
print(response)

# Define the encounter
with open('fhir-resources/encounter-template.json') as f:
  encounter_dict = json.load(f)


# Add Patient Id to Encounter
encounter_dict['subject']['reference'] = "Patient/" + patient_id
# Create Emergency Encounter Json
encounter_dict['class']['code'] = "EMER"
emergency_encounter = json.dumps(encounter_dict)
# Define Request Emergency Encounter
response_emergency = requests.request("POST", url + "Encounter", headers=headers, data=emergency_encounter)
# Get the ID of the amulatory encounter
emergency_encounter_id = json.loads(response_emergency.text)['id']

# Create Amulatory Encounter
encounter_dict['class']['code'] = "AMB"
ambulatory_encounter = json.dumps(encounter_dict)
# Define Request Ambulatory Encounter
response = requests.request("POST", url + "Encounter", headers=headers, data=ambulatory_encounter)

# Get the ID of the amulatory encounter
ambulatory_encounter_id = json.loads(response.text)['id']


# Add radius Fracture
with open('fhir-resources/condition-radius-fracture.json') as f:
  radius = json.load(f)

# Set Refs (Patient, Encounter)
radius['subject']['reference'] = "Patient/" + patient_id
radius['encounter']['reference'] = "Encounter/" + emergency_encounter_id

radius = json.dumps(radius)

response = requests.request("POST", url + "Condition", headers=headers, data=radius)
print(response)

# Add ulna Fracture
with open('fhir-resources/condition-ulna-open-fracture.json') as f:
  ulna = json.load(f)

# Set Refs (Patient, Encounter)
ulna['subject']['reference'] = "Patient/" + patient_id
ulna['encounter']['reference'] = "Encounter/" + emergency_encounter_id

ulna = json.dumps(ulna)

# POST
response = requests.request("POST", url + "Condition", headers=headers, data=ulna)

# Add diabetes
with open('fhir-resources/condition-diabetes.json') as f:
  diab = json.load(f)

# Set Refs (Patient, Encounter)
diab['subject']['reference'] = "Patient/" + patient_id
diab['encounter']['reference'] = "Encounter/" + ambulatory_encounter_id

diab = json.dumps(diab)

# POST
response = requests.request("POST", url + "Condition", headers=headers, data=diab)
print(response)
print("Patient ID:\t" + patient_id)
print("Emergency Encounter ID:\t " + emergency_encounter_id)
print("Ambulatory ID:\t" + ambulatory_encounter_id)

