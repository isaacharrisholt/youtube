# Seed the API with some data
# Usage: ./seed.sh <number, default 50>

# Set the number of Pokemon to seed
if [ -z "$1" ]; then
  NUMBER=50
  echo "No number specified, defaulting to $NUMBER"
else
  NUMBER=$1
fi

# If the number is greater than the number of
# Pokemon in the file, set it to the number of
# Pokemon in the file
NUMBER_IN_FILE=$(wc -l pokemon.txt | awk '{print $1}')
if [ $NUMBER -gt $NUMBER_IN_FILE ]; then
  NUMBER=$NUMBER_IN_FILE
  echo "Setting to maximum number of Pokemon in file: $NUMBER"
fi

# Seed the API
echo "Seeding $NUMBER Pokemon"
head -n $NUMBER pokemon.txt \
  | xargs -I{} curl 'http://localhost:8000/pokemon/{}' \
  > /dev/null 2>&1
echo "Seeded $NUMBER Pokemon"
