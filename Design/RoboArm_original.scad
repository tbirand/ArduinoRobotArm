use <MCAD/involute_gears.scad>

module cutout() {
	difference() {
		rotate([45,0,0]) cube([33,9,9]);
		translate([-0.5,-6,11]) cube([34,10,10]);
		translate([-0.5,6.3,0]) cube([34,10,10]);
		translate([-0.5,-16.3,0]) cube([34,10,10]);
	}
}

module cageUp(withServo) {
	difference() {
		union() {
			translate([-12.5,-8,0]) cube([25,16,17.2]);
			difference() {
				translate([-16.1,-8,10]) cube([32.2,16,7.2]);
				translate([11,-8.25,11]) rotate([0,45,0]) cube([30, 16.5, 30]);		
				translate([-11,-8.25,11]) rotate([0,-135,0]) cube([10, 16.5, 10]);
			}
		}
		translate([-11.75,-6.3,1]) cube([23.5,12.6,16.3]);
		translate([-13,-6.3,3]) cube([26,12.6,7]);
		translate([-16.5,0,3.65]) cutout();
		translate([-10,-8.1,1]) cube([20,16.2,10]);
		translate([-5,-8.1,1]) cube([10,16.2,14.7]);
		translate([-3.7,-10,4.65]) rotate([0, 0, 90]) cutout();
		translate([3.7,-10,4.65]) rotate([0, 0, 90]) cutout();
		translate([13.75,0,14.3]) cylinder(r=1,h=3,$fn=45);
		translate([-13.75,0,14.3]) cylinder(r=1,h=3,$fn=45);
	}
	if (withServo) {
		translate([11.5,6.3,1]) rotate([0,0,180]) servo();
	}
}

module cageSide(withServo, mount) {
	difference() {
		rotate([-90,0,0]) union() {
			translate([-13.5,-8,0]) cube([27,16,17.2]);
			translate([-16.1,-8,12.2]) cube([32.2,16,5]);
		}
		rotate([-90,0,0]) translate([-11.75,-6.3,1]) cube([23.5,12.6,16.3]);
		rotate([-90,0,0]) translate([11,-12,3.5]) cube([3,15,4]);
		rotate([-90,0,0]) translate([13.75,0,10.3]) cylinder(r=1,h=8,$fn=45);
		rotate([-90,0,0]) translate([-13.75,0,10.3]) cylinder(r=1,h=8,$fn=45);
		rotate([-90,0,0]) translate([-11.75,-10,1]) cube([23.5,12.6,16.3]);
	}
	if (mount) {
		translate([5.5, 0, 0]) rotate([90, 0, 0]) union() {
			cylinder(r=6.2, h=0.5, $fn=45);
			difference() {
				cylinder(r=5, h=3.5, $fn=45);
				translate([0,0,-0.05]) cylinder(r=1.1, h=4, $fn=45);
			}
		}
		color("Green") rotate([-90,0,0]) translate([5.3, 4.95, -3.5]) cube([0.4, 5, 2.5]);
	}
	if (withServo) {
		translate([11.8,1,-6.3]) rotate([90,0,180]) servo();
	}
}

module footBar(length,width,height) {
	translate([-length/2,-width/2,0]) cube([length,width,height]);
	translate([-length/2,0,0]) cylinder(r=width/2,h=height,$fn=45);
	translate([length/2,0,0]) cylinder(r=width/2,h=height,$fn=45);
}

module foot(withServo) {
	footBar(100,10,3);
	rotate([0,0,90]) footBar(100,10,3);
	translate([-5.5,0,2]) cageUp(withServo);
	translate([-18,-8,0]) cube([25,16,3]);
}

module swing(withServo) {
	translate([-5.5,-12.5,12.9]) cageSide(withServo, true);
	difference() {
		union() {
			cylinder(r=20,h=5,$fn=45);
			translate([-45, 17.5, 2.5]) rotate([0, 90, 0]) cylinder(r=2.5, h=45, $fn=45);
			translate([-27, 17.4, 2.5]) rotate([60, 90, 0]) cylinder(r=2.5, h=20, $fn=45);
		}
		translate([0,0,-0.05]) cylinder(r=3,h=5.1,$fn=45);
		translate([0, -18, 5.1]) cube([30, 10, 2], center=true);
		translate([0, 18, 5.1]) cube([30, 10, 2], center=true);
	}
}

module armPart(ri) {
	difference() {
		union() {
			cube([20, 2, 16]);
			translate([0,0,8]) rotate([-90,0,0]) cylinder(r=8, h=2, $fn=45);
		}
		translate([0, -0.1, 8]) rotate([-90,0,0]) cylinder(r=ri, h=2.2, $fn=45);
	}
}

module rampPart(length) {
	difference() {
		cube([length, 8, 8]);
		translate([0,3,0]) rotate([30, 0, 0]) translate([-0.1, -8, 0]) cube([length+0.2,8,8]);
		translate([-0.1,5,0]) rotate([-30, 0, 0]) cube([length+0.2,8,8]);
		translate([-0.1,4,10]) rotate([0,90,0]) cylinder(r=5, h=length+0.2, $fn=45);
	}
}

module springHolder() {
	rampPart(20);
	translate([1.7,0,0.1]) rotate([0,-15,0]) translate([-5,0,0]) rampPart(5);
	translate([-1.5,0,-0.7]) rotate([0,-30,0]) translate([-5,0,0]) rampPart(5);
	translate([18,4,0]) cylinder(r=1, h=8, $fn=45);
	translate([18,4,4.5]) rotate([0,30,0]) cylinder(r=1, h=4, $fn=45);
	translate([18.5,4,7.5]) cylinder(r=1.5, h=1, $fn=45);
	translate([19.5,4,7.5]) cylinder(r=1.5, h=1, $fn=45);
	translate([18.5,2.5,7.5]) cube([1,3,1]);
}

module arm(withServo, spring) {
	translate([44,-12.5,8]) difference() {
		cageSide(withServo, true);
		translate([0,0,-13]) cube([40,40,10], center=true);
	}
	translate([0,-15,0]) armPart(5.2);
	translate([0,15.5,0]) armPart(3.6);
	translate([20, -15, 0]) rotate([0, 0, 45]) cube([6, 2, 16]);
	translate([22.5, -12.5, 0]) cube([8, 2, 16]);
	translate([20, 17.5, 0]) rotate([0, 0, -45]) translate([0, -2, 0]) cube([6.35, 2, 16]);
	translate([22.5, -12.5, 0]) cube([2, 25.5, 16]);
	translate([23, -0.3, 0]) cube([5, 5, 16]);
	translate([9, 17.4, 0]) cube([6,4.5,5]);
	translate([9, 19.9, 4.9]) cube([6,2,6.2]);
	translate([9, 17.4, 11]) cube([6,4.5,5]);
	if (spring) {
		translate([0,12.5,15.9]) springHolder();
	}
}

module armFront(withServo) {
	translate([28,0.5,8]) rotate([0,0,-90]) difference() {
		cageSide(withServo, false);
		translate([-20,15.3,-10]) cube([43,2,20]);
	}
	translate([0,-15,0]) armPart(5.2);
	translate([0,15.5,0]) armPart(3.6);
	translate([20, -15, 0]) rotate([0, 0, 45]) cube([6, 2, 16]);
	translate([21.5, -13, 0]) cube([7, 2, 16]);
	translate([22.5, 12, 0]) cube([6, 2, 16]);
	translate([20, 17.5, 0]) rotate([0, 0, -45]) translate([0, -2, 0]) cube([6.35, 2, 16]);
	translate([22.5, -13, 0]) cube([2, 27, 16]);
	translate([9, 17.4, 0]) cube([6,4.5,5]);
	translate([9, 19.9, 4.9]) cube([6,2,6.2]);
	translate([9, 17.4, 11]) cube([6,4.5,5]);
}

module frontPlate() {
	rotate([0,-90,0]) difference() {
		cube([2,43,20]);
		translate([-4,31.25,10]) rotate([0,90,0]) cylinder(r=1,h=8,$fn=45);
		translate([-4,3.75,10]) rotate([0,90,0]) cylinder(r=1,h=8,$fn=45);
		translate([-1,5.75,3.75]) cube([4,23.5,12.6]);
	}
}

module gripperGear(outerRadius,innerRadius) {
	outerteeth=10;
	pitch = outerRadius/outerteeth*360;
	echo("pitch: ", pitch);
	innerteeth=12;
	innerpitch = innerRadius/innerteeth*360;
	rotate([0,0,-4]) difference() {
		gear (number_of_teeth=outerteeth,
			pressure_angle=18,
			circular_pitch=pitch,
   	   gear_thickness = 3,
      	rim_thickness = 3,
	      hub_thickness = 3,
			bore_diameter = 1.5);
		translate([0,0,1]) 
			gear (number_of_teeth=innerteeth,
				pressure_angle=45,
				circular_pitch=innerpitch,
   		   gear_thickness = 2.5,
      		rim_thickness = 2.5,
	      	hub_thickness = 2.5,
				bore_diameter = 0);
	}
}

module gripper() {
	difference() {
		cube([40,23.6,11.5]);
		translate([17.5,3.5,-0.5]) cube([24,16.6,13]);
		translate([19.5,1.5,-0.5]) cube([12,20.6,13]);
		translate([35.6,1.6,-0.5]) cube([2.4, 20.4, 20]);
		translate([0,-0.1,5]) rotate([0,-12,0]) cube([38,24,11.5]);
		translate([46,0,0]) rotate([0,0,45]) translate([-5,-5,-0.1]) cube([10,10,12]);
		translate([31.5,8.6,0]) rotate([0,0,45]) translate([-5,-5,-0.1]) cube([10,10,12]);
		translate([46,23.6,0]) rotate([0,0,45]) translate([-5,-5,-0.1]) cube([10,10,12]);
		translate([31.5,15,0]) rotate([0,0,45]) translate([-5,-5,-0.1]) cube([10,10,12]);
		translate([9,-1.8,0]) rotate([0,0,45]) translate([-7.5,-7.5,-0.1]) cube([15,15,12]);
		translate([9,25.3,0]) rotate([0,0,45]) translate([-7.5,-7.5,-0.1]) cube([15,15,12]);
		translate([-0.1,-0.1,-0.1]) cube([9.1, 9, 12]);
		translate([-0.1,14.7,-0.1]) cube([9.1, 9, 12]);
		translate([12.7,11.8,-0.1]) cylinder(r=3,h=12);
		translate([19.5,-0.1,3]) cube([3.7,2.5,1.4]);
		translate([23.5,-0.1,2]) cube([3.9,2.5,4.4]);
	}

*%	translate([0,0,11.5]) rotate([-90,0,0]) scale([10,10,10]) import("Gripper_v5.stl");
}

module rackTooth() {
	difference() {
		translate([-0.5,0,0]) linear_exturde_flat_option(height=3.5) {
		involute_gear_tooth(5,5,5,6,7.5,10);
		}
		translate([-3.2,-3.2,-0.1]) cube([5,5,4]);
	}
}

module gripperRack() {
	cube([3.5,30,3.5]);
	for (i=[0:7]) {
		translate([0, 4 + 2.96*i, 0]) rackTooth();
	}
	translate([-2.45,4,0]) cube([2.5,1,3.5]);
	translate([-4.4,2.5,0]) cube([2,4,3.5]);
}

module servo() {
	color("LightBlue", 0.5) {
		cube([23.5,12.6,16.4]);
		translate([-4.65,0,16.3]) difference() {
			cube([32.8,12.6,2]);
			translate([2.65,6.3,-0.1]) cylinder(r=1,h=3,$fn=45);
			translate([32.8-2.65,6.3,-0.1]) cylinder(r=1,h=3,$fn=45);
		}
		translate([0,0,18.2]) cube([23.5,12.6,4.4]);
		translate([6.3,6.3,22.5]) cylinder(r=6.3,h=4.1,$fn=45);
		translate([6.3,6.3,26.5]) cylinder(r=2.25,h=2.8,$fn=45);
	}
}

module overview() {
	foot(true);
	translate([0,0,38]) swing(true);
	translate([0,0,43]) arm(true, true);
	translate([49.5,0,43]) arm(true, false);
	translate([99,0,43]) {
		armFront(true);
		translate([45,18,-2]) rotate([180,90,0]) frontPlate();
		translate([81,-15.5,20]) rotate([90,180,0]) gripper();
// gripperRack and gripperGear are commented because
// they slow down rendering considerably on my PC
*		translate([58,-22.5,18]) rotate([0,90,0]) gripperRack();
		translate([81,3.5,-3]) rotate([-90,180,0]) gripper();
*		translate([58,12.5,-1]) rotate([0,-90,180]) gripperRack();
*		translate([61,-5,8.5]) rotate([0,-90,0]) gripperGear(4.5,2.5);
	}
}

// print one foot
*foot(false);
// print one swing
*swing(false);
// print one arm with spring holder
*arm(false, true);
// print one arm without spring holder
*arm(false, false);
// print one armFront
*armFront(false);
// print one frontPlate
*frontPlate();
// print one gripperGear
*gripperGear(4.5,2.5);
// print two gripper
*gripper();
// print two gripperRack
*gripperRack();

// shows the complete thing
overview();
