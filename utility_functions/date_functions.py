from datetime import datetime
def getToday():
    now = datetime.now()
    date = now.strftime("%Y-%m-%d")
    return str(date)

def getCurDateTime():
    now = datetime.now()
    return now.strftime("%Y-%m-%d %H:%M:%S")