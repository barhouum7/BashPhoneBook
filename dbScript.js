print("\n\t\t--->> Running testMyDb.js")
db.stats()

if (db.stats()) {
	print("\n\t\t--->> MongoDb Running.")
}else print("\n\t\t--->> MongoDb NOT Running.")

print("\n\t\t--->> Available DataBases.")
show dbs;
print("\n <<-------------------- Creating a New Collection -------------------->>")
db.createCollection("contactRecord", { capped: true, size: 6142800, max: 10000 } );