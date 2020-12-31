print("\n\t\t--->> Running testMyDb.js")
if (db.stats()) {
	print("\n\t\t--->> MongoDb Running.")
}else print("\n\t\t--->> MongoDb NOT Running.")

db.stats()

print("\n\t\t--->> Available DataBases.")
show dbs;
print("\n\t\t--->> Available Collections.")
show collections;


db.contacts.insertOne(
{
    firstName: $contact_firstName,
    lastName: $contact_lastName,
    gender: $contact_gender,
    phoneNumber: $contact_number,
    email: $contact_email,
    address: $contact_address
    
  }
)