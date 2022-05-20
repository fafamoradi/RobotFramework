import  jdatetime

def convertDate(txt):
    x = txt.split("T")
    y = x[0].split("-")
    z = jdatetime.date.fromgregorian(day=int(y[2]),month=int(y[1]) ,year= int(y[0]))
    h=str(z) + "T" + x[1]
    return (h)
