# Piegraph-function
Creates Piesgraphs. Areas of segments are changed by varying the radius not the angles.

## Examples
### Plot with 3 proportions and a grey area
`circle.segments(filename = "circle", proportions = c(.7, .1, .15), grey.proportion = .05, colors =c("#C0C0C0", "#FFFF00", "#00FFFF"), grey.color = "#808000" ) `
### Plot with 5 Proportion segments and a grey are, the total angle of the segments is increased to 225°
`circle.segments("circle", proportions = c(3,2,3,1,1.5), grey.proportion = 3 )`
### butterfly
 `for(k in 1:10){
   for(i in c(seq(220,140,-10), seq(140, 240, 20))){
     circle.segments(filename = "1", proportions = c(10:1, 1:10), grey.proportion = 10, total.angle = i)
     Sys.sleep(.2)
   }
 } `
 
 
