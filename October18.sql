Run in mongo folder
docker run --rm -d --name mongo -p 27017:27017 -v .:/data -w /data pitzcarraldo/alpine-node-mongo
docker run --rm -d --name mongo -p 27017:27017 -v ./db:/data/db -w /data/db/pitzcarraldo/alpine-node-mongo

docker exec -it mongo mongo book


db.dropDatabase()
db.towns.insert({
name: "Quezon City",
population: 2936116,
last_census: ISODate("2015-08-01"),
famous_for: [ "circle", "mayor dated a celebrity", "food" ],
mayor: {
  name: "Herbert Bautista",
  party: "PDP-Laban"
}
})

function insertCity(
name, population, last_census,
famous_for, mayor_info
) {
db.towns.insert({
  name: name,
  population: population,
  last_census: ISODate(last_census),
  famous_for: famous_for,
  mayor:  mayor_info
});
print("Created city!");
}

insertCity("City of Manila", 1780148, "2015-08-01", ["intramuros"], { name: "Joseph Estrada", party: "PMP" });
insertCity("City of Makati", 582602, "2015-08-01", ["business district", "food", "malls"], { name: "Abby Binay", party: "UNA" });
insertCity("City of Mandaluyong", 386276, "2015-08-01", ["business district", "food", "malls"], { name: "Carmelita Abalos", party: "UNA" });
insertCity("City of Pasig", 755300, "2015-08-01", ["business district", "food", "malls"], { name: "Bobby Eusebio", party: "Nacionalista" })
insertCity("City of San Juan", 122180, "2015-08-01", ["malls", "schools"], { name: "Guia Gomez", party: "UNA" });
insertCity("Pasay City", 416522, "2015-08-01", ["malls", "airport"], { name: "Tony Calixto", party: "LP" });
insertCity("Taguig City", 804915, "2015-08-01", ["malls", "parks"], { name: "Lani Cayetano", party: "Nacionalista" });

db.towns.find(
{},
{_id:0, name: 1, mayor: 1});

-- Get all mayors who are party with lp
db.towns.find(
	{
	'mayor.party': 'LP' }, {_id: 0, name: 1, mayor: 1 
	});

--Find mayor whos name starts with J
db.towns.find(
	{
	'mayor.name': /^J/ },
	{ _id: 0, name: 1, mayor: 1 }
	);

db.towns.find(
	{
	'mayor.party': {
	$in: [
		'LP', 'Nacionalista']
	} },
	{ _id: 0, name: 1, mayor: 1}
	);


insertCity("Taguig City", 804915, "2015-08-01", ["malls", "parks"], { name: "Lani Cayetano", party: "Nacionalista" });

-- Get object id
db.towns.find({}, {_id: 1, name: 1});

-- Delete object that was just inserted
db.towns.remove({_id:ObjectId("59e703f9de69288009e8604c")});

-- Update famous for keyword 
-- First parameter is condition
db.towns.update(
	{
		name: 'City of Manila'
	},
	{
		$push: { famous_for: 'historical places'}
		-- Instead of $set
	}
);


db.towns.find({}, {_id: 1, name: 1, famous_for: 1});


db.towns.find({}, {_id: 0, population: 1, name: 1});
-- Update towns and add to manila's population
db.towns.update(
	{
	name: 'City of Manila'
	},
	{
		$inc: { population: 1000000 }
	}
);