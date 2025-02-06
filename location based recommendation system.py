import pyodbc

def get_nearby_places(subway_station, category):
    try:
        # Establish connection to the SQL Server database
        conn = pyodbc.connect('DRIVER={SQL Server};SERVER=PCH_SINTHIS;DATABASE=TorontoCMS;Trusted_Connection=yes;')
        cursor = conn.cursor()

        # Call the stored procedure with the user's input
        cursor.execute("EXEC GetPlaces @SubwayStationName=?, @Category=?", subway_station, category)

        # Fetch the results
        results = cursor.fetchall()

        if results:
            print(f"Nearby {category.lower()}s near {subway_station}:")
            for row in results:
                print(f"Name: {row[0]}, Type: {row[1]}, Location: ({row[2]}, {row[3]})")
        else:
            print(f"No nearby {category.lower()}s found for {subway_station}.")
        
        # Close the connection
        conn.close()

    except Exception as e:
        print(f"Error: {e}")

# Get user input
subway_station = input("Enter the nearest subway station: ")
category = input("Choose category (Restaurant or Grocery): ")

# Get nearby places based on user input
get_nearby_places(subway_station, category)
