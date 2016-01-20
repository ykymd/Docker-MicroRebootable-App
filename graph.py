import datetime
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import csv
import codecs
import sys

param = sys.argv

f = codecs.open(param[1], "r", "utf-8_sig")
data = csv.reader(f)
x = []
y = []

for row in data:
	x.append(row[0])
	y.append(row[1])

fig = plt.figure()
ax = fig.add_subplot(111)
ax.plot(x,y)
#days = mdates.DayLocator(interval=3)
#daysFmt = mdates.DateFormatter("%Y-%m-%d")
#ax.xaxis.set_major_locator(days)
#ax.xaxis.set_major_formatter(daysFmt)
#fig.autofmt_xdate()
plt.tick_params(pad=10)
plt.savefig("./"+param[1]+".png")
f.close()