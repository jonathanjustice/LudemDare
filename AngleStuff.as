package {
	import flash.geom.Point;
	public class AngleStuff {
		public function AngleStuff() {
			
		}
	
		public static function degreesToSlope(deg:Number):Point {
			var radians:Number = (deg-90) * Math.PI / 180;
			return new Point(Math.cos(radians), Math.sin(radians));
		}
		
		public static function getAngleBetweenTwoPointObjects(pt1:Point, pt2:Point):Number {
			var distanceX : Number = pt1.x - pt2.x;
			var distanceY : Number = pt1.y - pt2.y;
			var angleInRadians : Number = Math.atan2(distanceY, distanceX);
			var angleInDegrees : Number = angleInRadians * (180 / Math.PI);
			return angleInDegrees;
		}
	}
}



