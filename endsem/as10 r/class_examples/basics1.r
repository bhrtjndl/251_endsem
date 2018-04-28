

courses <- c("cs251", "cs330", "cs315")
regs <- c(110, 90, 70)
drops <- c(5, 3, 1)

#srecs <- data.frame(courses, regs, drops)
#srecs
#class(srecs)
#str(srecs)

srecs1 <- data.frame(CourseNo = courses, Registrations = regs, Drops = drops)
#srecs1
#class(srecs1)
#str(srecs1)

stars <- c(10, 10 ,2);
srecs2 <- cbind(srecs1, Stars = stars)
#srecs2

srecs3 <- cbind(Seq = seq(1,2,0.5), srecs2)
#srecs3
#str(srecs3)

regs_e <- srecs3 $ "Registrations"
regs_e 
str(regs_e)
print(regs_e)
#
