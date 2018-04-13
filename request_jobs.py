import sqlite3
import json

conn = sqlite3.connect('./db/development.sqlite3')
c = conn.cursor()

c.execute('SELECT items.id, models.model_data, filaments.description, items.print_speed_id, items.print_height, items.print_width, items.print_depth FROM items JOIN models ON items.model_id = models.id JOIN filaments On items.filament_id = filaments.id WHERE items.in_cart=\'f\'')
results = c.fetchall()

jobs = {}
jobs['items'] = []
with open('jobs.JSON','w') as f:
  for each in reversed(results):
    item = {}
    item['id'] = str(each[0])
    item['model'] = each[1].split(':')[1].split(',')[0].split('"')[1]
    item['speed'] = 'regular' if each[3] == 1 else 'express'
    item['height'] = str(each[4])
    item['width'] = str(each[5])
    item['depth'] = str(each[6])
    jobs['items'].append(item)
  f.write(json.dumps(jobs, indent=4))
f.close()

# sample load JSON file and read first item
with open('jobs.JSON') as json_data:
  items = json.load(json_data)
  print items['items'][0]
