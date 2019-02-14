library(knitr)
library(kableExtra)
library("lattice")
library("survival")
library("Formula")
library("ggplot2")

# 药物剂量
dose <- c(20, 30, 40, 50, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)
dose_table <- data.frame(dose, drugA, drugB)

dose_table

plot(dose, drugA, type="b")

png(filename = "my_plot.png")
# jpeg(filename = "my_plot.jpg")
# pdf(file="my_plot.pdf")
# postscript(file = "my_plot.ps")

opar <- par(no.readonly = TRUE)
opar[1:2]

# lty: change line type to dashed (=2), pch: change symbol to solid triangle (=17)
par(lty=2, pch=17)
plot(dose, drugA, type="b")
# 恢复初始配置
par(opar)

plot(dose, drugA, type = "b", lty=2, pch=17)

n <- 10
mycolors <- rainbow(10)
pie(rep(1, n), labels = mycolors, col = mycolors)

n <- 10
mygrays <- gray(0:n/n)
pie(rep(1, n), labels = mygrays, col = mygrays)

library(RColorBrewer)
display.brewer.all()

n <- 7
mycolors <- brewer.pal(n, "RdYlGn")
barplot(rep(1,n), col=mycolors)

par(family="serif")

windowsFonts(
  A=windowsFont("Arial Black"),
  B=windowsFont("Bookman Old Style"),
  C=windowsFont("Comic Sans MS")
)
# 将图表字体设置为 Arial Black
par(family = "A")

# PDF 字体
names(pdfFonts())
# 生成 pdf
pdf(file="myplot.pdf", family = "fontname")
# PostScript Format 字体
names(postscriptFonts())
# 生成 PSF
postscript(file = "myplot.ps", family = "fontname")

# 4 inch 宽，3 inch 高，上下边距为 1 inch，0.2 inch 右边距，0.5 inch 左边距
par(pin = c(4,3), mai = c(1, .5, 1, .2))

dose <- c(20, 30, 40, 45, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)

opar <- par(no.readonly=TRUE)


par(pin=c(2,3))
par(lwd=2, cex=1.5)
par(cex.axis=.75, font.axis=3)
plot(dose, drugA, type="b", pch=19, lty=2, col="red")
plot(dose, drugB, type="b", pch=23, lty=6, col="blue", bg="green")
par(opar)

plot(dose, drugA, type="b",
     col="red", lty=2, pch=2, lwd=2,
     main="Clinical Trials for Drug A",
     sub="This is hypothetical data",
     xlab="Dosage",
     ylab="Drug Response",
     xlim=c(0,60), ylim=c(0,70))

plot.new()
title(main="main title", sub="subtitle",
      xlab="x-axis label", ylab="y-axis label")

plot.new()
title(main="My Title", col.main="red",
      sub="My Subtitle", col.sub="blue",
      xlab="My X label", ylab="My Y label",
      col.lab="green", cex.lab=0.75)

# axis(side, at=, labels=, pos=, lty=, col=, las=, tck=, ...)

# Specifies data
x <- c(1:10)
y <- x
z <- 10/x
opar <- par(no.readonly=TRUE)
# Increases margins
par(mar=c(5, 4, 4, 8) + 0.1)
# Plots x vs. y, suppressing annotations
plot(x, y, type="b",
     pch=21, col="red",
     yaxt="n", lty=3, ann=FALSE) 
# Adds an x versus 1/x line
lines(x, z, type="b", pch=22, col="blue", lty=2)
# Draws the axes
axis(2, at=x, labels=x,
     col.axis="red", las=2)
axis(4, at=z, labels=round(z, digits=2),
     col.axis="blue", las=2, cex.axis=0.7, tck=-.01)
# Adds titles and text
mtext("y=1/x", side=4, line=3, cex.lab=1, las=2, col="blue")
title("An Example of Creative Axes",
      xlab="X values",
      ylab="Y=X")
par(opar)

abline(h=c(1,5,7))
abline(v=seq(1, 10, 2), lty=2, col="blue")

# legend(location, title, legend, ...)

# Compare A with B
dose <- c(20, 30, 40, 45, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)
opar <- par(no.readonly=TRUE)
# Increases line, text, symbol, and label font size
par(lwd=2, cex=1.5, font.lab=2)
# Generates the graph
plot(dose, drugA, type="b",
     pch=15, lty=1, col="red", ylim=c(0, 60),
     main="Drug A vs. Drug B",
     xlab="Drug Dosage", ylab="Drug Response")
lines(dose, drugB, type="b",
      pch=17, lty=2, col="blue")
abline(h=c(30), lwd=1.5, lty=2, col="gray")
# Adds minor tick marks
library(Hmisc)
minor.tick(nx=3, ny=3, tick.ratio=0.5)
legend("topleft", inset=.05, title="Drug Type", c("A","B"),
       lty=c(1, 2), pch=c(15, 17), col=c("red", "blue"))
par(opar)

attach(datasets::mtcars)
plot(wt, mpg,
     main="Mileage vs. Car Weight",
     xlab="Weight", ylab="Mileage",
     pch=18, col="blue")
text(wt, mpg,
     row.names(mtcars),
     cex=0.6, pos=4, col="red")
detach(datasets::mtcars)

opar <- par(no.readonly=TRUE)
par(cex=1.5)
plot(1:7,1:7,type="n")
text(3,3,"Example of default text")
text(4,4,family="mono","Example of mono-spaced text")
text(5,5,family="serif","Example of serif text")
par(opar)

attach(mtcars)
opar <- par(no.readonly=TRUE)
par(mfrow=c(2,2))
plot(wt,mpg, main="Scatterplot of wt vs. mpg")
plot(wt,disp, main="Scatterplot of wt vs. disp")
hist(wt, main="Histogram of wt")
boxplot(wt, main="Boxplot of wt")
par(opar)
detach(mtcars)

attach(mtcars)
layout(
  matrix(c(1,1,2,3), 2, 2, byrow=TRUE)
)
hist(wt)
hist(mpg)
hist(disp)
detach(mtcars)

attach(mtcars)
layout(matrix(c(1, 1, 2, 3), 2, 2, byrow = TRUE),
       widths=c(3, 1), heights=c(1, 2))
hist(wt)
hist(mpg)
hist(disp)
detach(mtcars)

opar <- par(no.readonly=TRUE)
par(fig=c(0, 0.8, 0, 0.8))
plot(mtcars$wt, mtcars$mpg,
     xlab="Miles Per Gallon",
     ylab="Car Weight")
# Adds a box plot above
par(fig=c(0, 0.8, 0.55, 1), new=TRUE)
boxplot(mtcars$wt, horizontal=TRUE, axes=FALSE)
# Adds a box plot to the right
par(fig=c(0.6, 1, 0, 0.8), new=TRUE)
boxplot(mtcars$mpg, axes=FALSE)
mtext("Enhanced Scatterplot", side=3, outer=TRUE, line=-3)
par(opar)
