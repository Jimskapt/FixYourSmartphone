
// size of your phone
phoneW=142;    // width
phoneH=72.5;   // height
phoneT=10;     // thickness
phoneR=10;     // radius

// margins between your phone and this case
margin=1;
marginX=margin;
marginY=margin;
marginZ=margin;

// thickness of the shell of the case
caseT=1;
screenMargin=4;

// scratch
scratchW=20+4;
scratchT=2+1;

// specific
speaker=true;
speakerX=phoneW/2-23;
speakerY=phoneH/2-12;
speakerW=5;
speakerH=8;

menuButtonW=20;

volumeX=-phoneW/2+30;
volumeY=-phoneH/2;
volumeZ=phoneT-3;
volumeW=25;
volumeH=3;

lockX=-phoneW/2+40;
lockY=+phoneH/2;
lockZ=phoneT-3;
lockW=15;
lockH=3;

// settings
$fn=50;

// system (DO NOT MODIFY)
radius=phoneR+caseT+max(marginX,marginY);
closeMargin=2*scratchT/3;
supportW=0.6;

// basic phone
translate([0,0,phoneT/2+caseT+marginZ])
  %cube([phoneW,phoneH,phoneT],center=true);

difference()
{
  union()
  {
    // basis (on behind phone)
    translate([0,0,caseT/2])
    {
      difference()
      {
        difference()
        {
          translate([-closeMargin,0,0])
            roundedRectangle(phoneW+2*(marginX+caseT)+2*closeMargin, phoneH+2*(marginY+caseT), caseT, radius);
          
          // close
          translate([-(phoneW/2+1+scratchT/2),0,0])
            cube([scratchT,scratchW,caseT+2],center=true);
          
          /*if(speaker)
          {
            translate([speakerX,speakerY,0])
              cube([speakerW+2*marginX,speakerH+2*marginY,caseT+2],center=true);
          }*/
        }
        
        for(x=[-1:+2:+1])
        {
          translate([x*(phoneW/2-30),0,0])
          {
            increment=(phoneH+2*marginY-2*4*scratchT)/2/4;
            
            for(y=[increment:increment+scratchT:phoneH/2+marginY])
            {
              translate([0,y,0])
                roundedRectangle(scratchW,scratchT,caseT+2,scratchT/4);
              
              translate([0,-y,0])
                roundedRectangle(scratchW,scratchT,caseT+2,scratchT/4);
            }
          }
        }
        
        // center rectangle
        translate([0,0,supportW])
          roundedRectangle(phoneH/2, 3*phoneH/4, caseT, phoneH/8);
      }
    }

    // shell
    translate([0,0,caseT+phoneT/2+marginZ])
    {
      for(y=[-1:+2:+1])
      {
        translate([+(phoneW/2-radius+marginX+caseT),0,0])
        {
          translate([0,y*(phoneH/2-radius+marginY+caseT),0])
          {
            difference()
            {
              cylinder(h=phoneT+2*marginZ,r=radius,center=true);
              cylinder(h=phoneT+2*marginZ+2,r=radius-caseT,center=true);
              
              translate([0,-y*radius,0])
                cube([2*radius,2*radius,phoneT+2*marginZ+3],center=true);
              translate([-radius,0,0])
                cube([2*radius,2*radius,phoneT+2*marginZ+3],center=true);
            }
          }
          
          translate([radius-caseT/2,0,0])
            cube([caseT,phoneH+2*(marginY+caseT-radius),phoneT+2*marginZ],center=true);
        }
        
        translate([-closeMargin,y*(phoneH/2+marginY+caseT-caseT/2),0])
            cube([phoneW+2*(marginX+caseT-radius)+2*closeMargin,caseT,phoneT+2*marginZ],center=true);
      }
      
      // supports
      for(y=[-1:+2:+1])
      {
        translate([-2*closeMargin-(phoneW+2*marginX+2*caseT)/2+radius,0,0])
        {
          translate([0,y*(phoneH/2-radius+marginY+caseT),0])
          {
            difference()
            {
              cylinder(h=phoneT+2*marginZ,r=radius,center=true);
              cylinder(h=phoneT+2*marginZ+2,r=radius-supportW,center=true);
              
              translate([0,-y*radius,0])
                cube([2*radius,2*radius,phoneT+2*marginZ+3],center=true);
              translate([+radius-2,0,0])
                cube([2*radius,2*radius,phoneT+2*marginZ+3],center=true);
            }
          }
          
          translate([-radius+supportW/2,0,0])
            cube([supportW,phoneH+2*(marginY+caseT-radius),phoneT+2*marginZ],center=true);
        }
      }
      translate([+2*closeMargin-(phoneW+2*marginX+2*caseT)/2+supportW/2,0,0])
      {
          cube([supportW,phoneH-phoneR,phoneT+2*marginZ+2],center=true);
      }
    }
    
    // top
    translate([0,0,phoneT+2*marginZ+caseT+caseT/2])
    {
      difference()
      {
        translate([-closeMargin,0,0])
            roundedRectangle(phoneW+2*(marginX+caseT)+2*closeMargin, phoneH+2*(marginY+caseT), caseT, radius);
        
        // close
        translate([-(phoneW/2+1+scratchT/2),0,0])
          roundedRectangle(scratchT,scratchW,caseT+2,scratchT/4);
        
        roundedRectangle(phoneW+2*marginX-2*screenMargin, phoneH+2*marginY-2*screenMargin, 2*caseT, phoneR+max(marginX,marginY)-screenMargin);
        
        if(menuButtonW>0)
        {
          translate([(phoneW+2*marginX-2*screenMargin)/2+screenMargin/2+caseT/2,0,0])
            cube([screenMargin+caseT+2,menuButtonW,caseT+2],center=true);
        }
      }
    }
  }
  
  // speaker
  if(speaker)
  {
    translate([speakerX,speakerY,caseT+4/2+0.5])
    {
      cube([phoneW/2,speakerH+2*2*marginY,4],center=true);
    }
  }
  
  // volume
  translate([volumeX,volumeY,volumeZ])
    cube([volumeW+2*marginX,phoneH/2,volumeH+2*marginZ],center=true);
  
  // lock
  translate([lockX,lockY,lockZ])
    cube([lockW+2*marginX,phoneH/2,lockH+2*marginZ],center=true);
}

module roundedRectangle(w,h,t,r)
{
  union()
  {
    // corners
    for(x=[-1:+2:+1])
    {
      for(y=[-1:+2:+1])
      {
        translate([x*(w/2-r),y*(h/2-r),0])
          cylinder(h=t,r=r,center=true);
      }
    }
    
    cube([w,h-2*r,t],center=true);
    cube([w-2*r,h,t],center=true);
  }
}