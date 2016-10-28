as.numeric(TRUE)

1==1

tocheck <- 1

if(tocheck==1)
{
  print ("hello")
}

check.bool <- function(x)
{
  if (x==1)
  {
    print ("hello")
  }
  else if (x==2)
  {
    print("hi")
  }
  else
  {
    print ("fuck")
  }
}

check.bool(4)

say.hello <- function()
{ 
  print("hello world")
}

say.hello()

check.order <- function(x)
{
  switch (x,
   a = print("action"),
   d = print("do"),
   print("othere")
  )
}
check.order(2+2)

ifelse (1==3, "yes","no")

totest <- c(1,0,3,1,0,2)
ifelse(totest==1, totest-2, "fuck")


