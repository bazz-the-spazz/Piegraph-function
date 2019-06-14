# Piegraph-function
Creates Piegraphs. Areas of segments are changed by varying the radius not the angles.

## Arguments
*filename*: name of the output svg file

*proportions*: vector of the proportions of the pie

*grey.proportion*: proportion of the grey area

*total.angle*: angle of the segments which is not occupied by the grey area

*colors*: Vector of colors of the proportions. Should be specified as character. If the vector is to long it also specify the grey color.

*grey.color*: color of the grey area (when not overridden by an overlong *colors* argument)

## Examples
### Plot with 3 proportions and a grey area
`circle.segments(filename = "circle", proportions = c(.7, .1, .15), grey.proportion = .05, colors =c("#C0C0C0", "#FFFF00", "#00FFFF"), grey.color = "#808000" ) `
### Plot with 5 proportion segments and a grey area
The total angle of the segments is automatically increased to 225°

`circle.segments("circle", proportions = c(3,2,3,1,1.5), grey.proportion = 3 )`
### Butterfly
Creates a moving picture of a flying moth. Requires a svg viewer that updates the picture automatically.

 `for(k in 1:10){
   for(i in c(seq(220,140,-10), seq(140, 240, 20))){
     circle.segments(filename = "circle", proportions = c(10:1, 1:10), grey.proportion = 10, total.angle = i);
     Sys.sleep(.2)
   }
 } `
 
 
