package brfv4.examples.face_tracking {
	import brfv4.BRFFace;
	import brfv4.BRFManager;
	import brfv4.as3.DrawingUtils;
	import brfv4.examples.BRFBasicAS3Example;

	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	public class candide_overlay extends BRFBasicAS3Example {
		
		override public function initCurrentExample(brfManager : BRFManager, resolution : Rectangle) : void {
	
			trace("BRFv4 - basic - face tracking - candide shape overlay\n" +
				"The Candide 3 model is calculated from the 68 landmarks.");
	
			// By default everything necessary for a single face tracking app
			// is set up for you in brfManager.init. There is actually no
			// need to configure much more for a jump start.
	
			brfManager.init(resolution, resolution, appId);
		};
	
		override public function updateCurrentExample(brfManager : BRFManager, imageData : BitmapData, draw : DrawingUtils) : void {
						
			// In a webcam example imageData is the mirrored webcam video feed.
			// In an image example imageData is the (not mirrored) image content.
	
			brfManager.update(imageData);
	
			// Drawing the results:
	
			draw.clear();
	
			// Face detection results: a rough rectangle used to start the face tracking.
	
			draw.drawRects(brfManager.getAllDetectedFaces(),	false, 1.0, 0x00a1ff, 0.5);
			draw.drawRects(brfManager.getMergedDetectedFaces(),	false, 2.0, 0xffd200, 1.0);
	
			// Get all faces. The default setup only tracks one face.
	
			var faces : Vector.<BRFFace> = brfManager.getFaces();
	
			for(var i : int = 0; i < faces.length; i++) {
	
				var face : BRFFace = faces[i];
	
				if(	face.state == brfv4.BRFState.FACE_TRACKING) {
	
					// Instead of drawing the 68 landmarks this time we draw the Candide3 model shape (yellow).
	
					draw.drawTriangles(	face.candideVertices, face.candideTriangles, false, 1.0, 0xffd200, 0.4);
					draw.fillTriangles(	face.candideVertices, face.candideTriangles, false, 0xcccccc, .5);
					//draw.drawVertices(	face.candideVertices, 2.0, false, 0xffd200, 0.4);
	
					// And for a reference also draw the 68 landmarks (blue).
	
				//	draw.drawVertices(	face.vertices, 2.0, false, 0x00a1ff, 0.4);
					
					draw.fillTriangles(	face.candideVertices, libTrianglesCandide, false, 0x337900, 0.8);
					
					draw.fillTriangles(	face.candideVertices, libTrianglesCandideUp, false, 0x667900, 0.8);
					
					draw.fillTriangles(	face.candideVertices, brows, false, 0x774400, 0.8);
					
					draw.fillTriangles(	face.candideVertices, eyes, false, 0xff0000, 1);
				}
			}
			
			

		}
		
				private var eyes : Vector.<int> = Vector.<int>([
		19,24,20,
		19,23,24,
		
		52,53,57,
		52,56,57
		
		]);
		
		
		private var brows : Vector.<int> = Vector.<int>([
			
		49,51,48,
49,51,50,

17,16,18,
18,16,15
		
		]);
		
			private var libTrianglesCandideUp : Vector.<int> = Vector.<int>([
			64,89,80,
80,89,82,
82,80,7,
7,82,87,
7,81,87,
81,79,7,
79,88,81,
88,31,79
		
		
		]);
		
			private var libTrianglesCandide : Vector.<int> = Vector.<int>([
64,89,86,
84,86,89,
84,8,86,
84,40,8,
8,40,83,
83,85,8,
83,85,88,
88,31,85
		]);
	}
}