package rcUnits.object.unit {
	import flash.geom.Matrix;
	import nape.geom.Mat23;
	
	import rcCommon.rcengine;
	use namespace rcengine;
	/**
	 * Класс Matrix представляет матрицу преобразования, определяющую способ сопоставления точек из одного пространства координат с точками в другом пространстве координат. Эти функции преобразования включают перемещение (изменение положения осей x и y), поворот, масштабирование и наклон. Все эти преобразования называются аффинные преобразования. При аффинных преобразованиях сохраняется прямолинейность линий, поэтому параллельные линии остаются параллельными. 
	 * @author FieryWall
	 */
	public class rcMatrix 
	{
		/**Значение, от которого зависит размещение пикселей вдоль оси x при масштабировании или повороте изображения.*/
		public var a:Number;
		/**Значение, от которого зависит размещение пикселей вдоль оси y при повороте или наклоне изображения.*/
		public var b:Number;
		/**Значение, от которого зависит размещение пикселей вдоль оси x при повороте или наклоне изображения.*/
		public var c:Number;
		/**Значение, от которого зависит размещение пикселей вдоль оси y при масштабировании или повороте изображения.*/
		public var d:Number;
		/**Расстояние, на которое перемещается каждая точка вдоль оси x.*/
		public var tx:Number;
		/**Расстояние, на которое перемещается каждая точка вдоль оси y.*/
		public var ty:Number;
		public function rcMatrix(a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0) 
		{
			edit(a, b, c, d, tx, ty);
		}
		/**
		 * Задает для членов объекта rcMatrix определенные значения
		 * @param	a - значения, которые следует задать для матрицы.
		 * @param	b
		 * @param	c
		 * @param	d
		 * @param	tx
		 * @param	ty
		 * @return  текущую матрицу
		 */
		public function edit(a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0):rcMatrix
		{
			this.a = a;
			this.b = b;
			this.c = c;
			this.d = d;
			this.tx = tx;
			this.ty = ty;
			return this;
		}
		/**
		 * Выполняет обратное преобразование исходной матрицы. Можно применить обратную матрицу к объекту для отмены преобразования, выполненного при применении исходной матрицы.
		 * @param	result (defoult = null) - ссылка на матрицу результата инвертирования. Если параметр не задан - редактируются переменные данной матрицы.
		 * @return  результат инвертирования, объект rcMatrix.
		 */
		public function invert(result:rcMatrix = null):rcMatrix
		{
			var det:Number = 1 / (this.a * this.d - this.c * this.b);
			
			var a:Number = this.d * det;
			var b:Number = this.c * det;
			var c:Number = this.b * det;
			var d:Number = this.a * det;
			var x:Number = -tx;
			var y:Number = -ty;
			
			result ||= this;
			result.edit(a, b, c, d, x, y);
			
			return result;
		}
		/**
		 * Сцепляет матрицу с текущей матрицей, фактически объединяя геометрические искажения двух матриц. В математическом представлении сцепление двух матриц равнозначно сложению матриц с использованием умножения. Например, если матрица m1 масштабирует объект с использованием коэффициента, равного четырем, а матрица m2 поворачивает объект на 1,5707963267949 радиан (Math.PI/2), то m1.concat(m2) преобразует m1 в матрицу, которая выполняет масштабирование объекта с коэффициентом, равным четырем, и поворачивает объект на Math.PI/2 радиан.
		 * @param	matrix - Матрица, которая будет сцеплена с текущей матрицей.
		 * @param	result (defoult = null) - ссылка на матрицу результата сцепления. Если параметр не задан - редактируются переменные данной матрицы.
		 * @return  результат сцепления, объект rcMatrix.
		 */
		public function concat(matrix:rcMatrix, result:rcMatrix = null):rcMatrix
		{
			var a:Number = matrix.a;
			var b:Number = matrix.b;
			var c:Number = matrix.c;
			var d:Number = matrix.d;
			var tx:Number = matrix.tx;
			var ty:Number = matrix.ty;
			result ||= this;		
			result.edit				
			(						
				this.a  * a + this.b  * c,
				this.a  * b + this.b  * d,
				this.c  * a + this.d  * c,
				this.c  * b + this.d  * d,
				this.tx * a + this.ty * c + tx,
				this.tx * b + this.ty * d + ty
			);
			
			return result;
		}
		/**
		 * Сцепляет матрицу с текущей матрицей, фактически объединяя геометрические искажения двух матриц, но в отличии от функции concat - редактирует значения перемещения точки tx и ty данной матрицы без сложения с соотвецтвующими значениями в предложенной матрице. В математическом представлении сцепление двух матриц равнозначно сложению матриц с использованием умножения. Например, если матрица m1 масштабирует объект с использованием коэффициента, равного четырем, а матрица m2 поворачивает объект на 1,5707963267949 радиан (Math.PI/2), то m1.concat(m2) преобразует m1 в матрицу, которая выполняет масштабирование объекта с коэффициентом, равным четырем, и поворачивает объект на Math.PI/2 радиан.
		 * @param	matrix - Матрица, которая будет сцеплена с текущей матрицей.
		 * @param	result (defoult = null) - ссылка на матрицу результата сцепления. Если параметр не задан - редактируются переменные данной матрицы.
		 * @return  результат сцепления, объект rcMatrix.
		 */
		public function concatLocal(matrix:rcMatrix, result:rcMatrix = null):rcMatrix
		{
			var a:Number = matrix.a;
			var b:Number = matrix.b;
			var c:Number = matrix.c;
			var d:Number = matrix.d;
			result ||= this;
			result.edit
			(
				this.a * a + this.b * c,
				this.a * b + this.b * d,
				this.c * a + this.d * c,
				this.c * b + this.d * d,
				this.tx * a + this.ty * c,
				this.tx * b + this.ty * d
			);
			
			return result;
		}
		/**
		 * Сцепляет матрицу с текущей матрицей, фактически объединяя геометрические искажения двух матриц, но в отличии от функции concat - не редактирует значения перемещения точки tx и ty. В математическом представлении сцепление двух матриц равнозначно сложению матриц с использованием умножения. Например, если матрица m1 масштабирует объект с использованием коэффициента, равного четырем, а матрица m2 поворачивает объект на 1,5707963267949 радиан (Math.PI/2), то m1.concat(m2) преобразует m1 в матрицу, которая выполняет масштабирование объекта с коэффициентом, равным четырем, и поворачивает объект на Math.PI/2 радиан. 
		 * @param	matrix - Матрица, которая будет сцеплена с текущей матрицей.
		 * @param	result (defoult = null) - ссылка на матрицу результата сцепления. Если параметр не задан - редактируются переменные данной матрицы.
		 * @return  результат сцепления, объект rcMatrix.
		 */
		public function concatABCD(matrix:rcMatrix, result:rcMatrix = null):rcMatrix
		{
			var a:Number = matrix.a;
			var b:Number = matrix.b;
			var c:Number = matrix.c;
			var d:Number = matrix.d;
			result ||= this;
			result.edit
			(
				this.a * a + this.b * c,
				this.a * b + this.b * d,
				this.c * a + this.d * c,
				this.c * b + this.d * d,
				tx,
				ty
			);
			
			return result;
		}
		/**
		 * Сцепляет матрицу с текущей матрицей, фактически объединяя геометрические искажения двух матриц, но в отличии от функции concat - не редактирует значения a, b, c, d. В математическом представлении сцепление двух матриц равнозначно сложению матриц с использованием умножения. Например, если матрица m1 масштабирует объект с использованием коэффициента, равного четырем, а матрица m2 поворачивает объект на 1,5707963267949 радиан (Math.PI/2), то m1.concat(m2) преобразует m1 в матрицу, которая выполняет масштабирование объекта с коэффициентом, равным четырем, и поворачивает объект на Math.PI/2 радиан.
		 * @param	matrix - Матрица, которая будет сцеплена с текущей матрицей.
		 * @param	result(defoult = null) - ссылка на матрицу результата сцепления. Если параметр не задан - редактируются переменные данной матрицы.
		 * @return  результат сцепления, объект rcMatrix.
		 */
		public function concatXYwithABCD(matrix:rcMatrix, result:rcMatrix = null):rcMatrix
		{
			var tx:Number = matrix.tx;
			var ty:Number = matrix.ty;
			result ||= this;
			result.edit
			(
				a, b, c, d,
				tx + this.tx * a + this.ty * c,
				ty + this.tx * b + this.ty * d
			)
			return result;
		}
		/**
		 * Слкладывает значения перемещения матриц
		 * @param	matrix - Матрица, которая будет сложена с текущей матрицей.
		 * @param	result(defoult = null) - ссылка на матрицу результата сложения. Если параметр не задан - редактируются переменные данной матрицы.
		 * @return  результат сложения, объект rcMatrix.
		 */
		public function concatXY(matrix:rcMatrix, result:rcMatrix = null):rcMatrix
		{
			var tx:Number = matrix.tx;
			var ty:Number = matrix.ty;
			result ||= this;
			result.edit
			(
				a, b, c, d,
				tx + this.tx,
				ty + this.ty
			);
			return result;
		}
		/**
		 * Применяет преобразование поворотом к объекту Matrix.
		 * @param	angle - Угол поворота (в радианах).
		 * @param	xy (defoult = true) - Указывает, будут ли редактироватся значения перемещения от поворота, если установить false - результат отображения будет транформироватся относительно локальной точки (0, 0).
		 * @param	result (defoult = null) - ссылка на матрицу результата поворота. Если параметр не задан - редактируются переменные данной матрицы.
		 * @return  результат поворота матрицы, объект rcMatrix.
		 */
		public function rotate(angle:Number, xy:Boolean = true, result:rcMatrix = null):rcMatrix
		{
			var ra:Number = Math.cos(angle);
			var rb:Number = Math.sin(angle);
			var rc:Number = -Math.sin(angle);
			var rd:Number = Math.cos(angle);
			
			var ma:Number = a;
			var mb:Number = b;
			var mc:Number =	c;
			var md:Number = d;
			var mtx:Number = tx;
			var mty:Number = ty;
			
			result ||= this;
			result.edit(
				ma * ra + mb * rc,
				ma * rb + mb * rd,
				mc * ra + md * rc,
				mc * rb + md * rd,
				xy ? mtx * ra + mty * rc : result.tx,
				xy ? mtx * rb + mty * rd : result.ty
			);
			return result;
		}
		/**
		 * Применяет геометрические преобразования, представленные объектом rcMatrix в вершинах прямоугольника rcRect.
		 * @param	rect - прямоугольник, вершины которого преобразовает объект rcMatrix.
		 */
		public function editRect(rect:rcRect):void
		{
			var left:Number = rect.left;
			var top:Number = rect.top;
			var right:Number = rect.right;
			var bottom:Number = rect.bottom;
			
			var a:Number = this.a > 0 ? this.a : -this.a;
			var b:Number = this.b > 0 ? this.b : -this.b;
			
			var Ax:Number = tx + left 	* a + top 		* c;
			var Ay:Number = ty + left 	* b + top 		* d;
			var Bx:Number = tx + right 	* a + top 		* c;
			var By:Number = ty + right 	* b + top 		* d;
			var Cx:Number = tx + right 	* a + bottom 	* c;
			var Cy:Number = ty + right 	* b + bottom 	* d;
			var Dx:Number = tx + left 	* a + bottom 	* c;
			var Dy:Number = ty + left 	* b + bottom 	* d;
			
			rect.left = min(Ax, Bx, Cx, Dx);
			rect.top = min(Ay, By, Cy, Dy);
			rect.right = max(Ax, Bx, Cx, Dx);
			rect.bottom = max(Ay, By, Cy, Dy);
		}
		
		[inline]
		private function max(a:Number, b:Number, c:Number, d:Number):Number
		{
			var max:Number = a;
			while (true){
				if (max >= b){
					if (max >= c){
						if (max >= d){
							break;
						}else{
							max = d;
						}
					}else{
						max = c;
					}
				}else{
					max = b
				}
			}
			return max;
		}
		
		[inline]
		private function min(a:Number, b:Number, c:Number, d:Number):Number
		{
			var min:Number = a;
			while (true){
				if (min <= b){
					if (min <= c){
						if (min <= d){
							break;
						}else{
							min = d;
						}
					}else{
						min = c;
					}
				}else{
					min = b;
				}
			}
			return min;
		}
		/**
		 * Применяет геометрические преобразования, представленные объектом rcMatrix в точке.
		 * @param	point - точка, которую преобразовывает объект rcMatrix.
		 */
		public function editPoint(point:rcPoint):void 
		{
			var x:Number = point.x;
			var y:Number = point.y;
			point.x = tx + x * a + y * c;
			point.y = ty + x * b + y * d;
		}
		/**
		 * Применяет геометрические преобразования, представленные объектом rcMatrix в точке, но без применения значений перемещения матрицы tx и ty.
		 * @param	point - точка, которую преобразовывает объект rcMatrix.
		 */
		public function editPointABCD(point:rcPoint):void 
		{
			var x:Number = point.x;
			var y:Number = point.y;
			point.x = x * a + y * c;
			point.y = x * b + y * d;
		}
		/**
		 * Применяет геометрические преобразования, представленные объектом rcMatrix для круга.
		 * @param	circle - круг, преобразовываемый объектом rcMatrix.
		 */
		public function editCircle(circle:rcCircle):rcCircle
		{
			var x:Number = circle.x;
			var y:Number = circle.y;
			circle.x = tx + x * a + y * c;
			circle.y = ty + x * b + y * d;
			circle.r = (a + d) / 2 * circle.r;
			return circle;
		}
		/**
		 * Перемещает матрицу вдоль осей x и y, как задано параметрами dx и dy.
		 * @param	dx - Значение перемещения вправо по оси x (в пикселях).
		 * @param	dy - Значение перемещения вправо по оси y (в пикселях).
		 */
		public function translate(dx:Number, dy:Number):void
		{
			tx += dx;
			ty += dy;
		}
		/**
		 * Копирует все данные матрицы из исходного объекта rcMatrix в вызывающий объект rcMatrix.
		 * @param	matrix - Объект rcMatrix, из которого следует скопировать данные.
		 * @return  возвращает данный объект rcMatrix.
		 */
		public function copyFrom(matrix:rcMatrix):rcMatrix
		{
			a = matrix.a;
			b = matrix.b;
			c = matrix.c;
			d = matrix.d;
			tx = matrix.tx;
			ty = matrix.ty;
			return this;
		}
		/**
		 * Копирует все данные матрицы из исходного объекта Matrix в вызывающий объект rcMatrix.
		 * @param	matrix - Объект Matrix, из которого следует скопировать данные.
		 * @return  возвращает данный объект rcMatrix.
		 */
		public function fromMatrix(matrix:Matrix):rcMatrix
		{
			a = matrix.a;
			b = matrix.b;
			c = matrix.c;
			d = matrix.d;
			tx = matrix.tx;
			ty = matrix.ty;
			return this;
		}
		/**
		 * Копирует все данные матрицы из вызывающего объекта rcMatrix в исходный объект Matrix.
		 * @param	weak - ссылка на матрицу Matrix. Если параметр не задан - создается новый объект Matrix.
		 * @return  объект Matrix.
		 */
		public function toMatrix(weak:Matrix = null):Matrix
		{
			weak ||= new Matrix();
			weak.a = a;
			weak.b = b;
			weak.c = c;
			weak.d = d;
			weak.tx = tx;
			weak.ty = ty;
			return weak;
		}
		/**
		 * Копирует все данные матрицы из исходного объекта Mat23 в вызывающий объект rcMatrix.
		 * @param	matrix - Объект Mat23, из которого следует скопировать данные.
		 * @return  возвращает данный объект rcMatrix.
		 */
		public function fromMat23(mat23:Mat23):rcMatrix
		{
			a = mat23.a;
			b = mat23.c;
			c = mat23.b;
			d = mat23.d;
			tx = mat23.tx;
			ty = mat23.ty;
			return this;
		}
		/**
		 * Копирует все данные матрицы из вызывающего объекта rcMatrix в исходный объект Mat23.
		 * @param	weak - ссылка на матрицу Mat23. Если параметр не задан - создается новый объект Mat23.
		 * @return  объект Mat23.
		 */
		public function toMat23(weak:Mat23 = null):Mat23
		{
			weak ||= new Mat23();
			weak.a = a;
			weak.b = c;
			weak.c = b;
			weak.d = d;
			weak.tx = tx;
			weak.ty = ty;
			return weak;
		}
		/**
		 * Копирует все данные матрицы из исходного объекта Matrix в вызывающий объект rcMatrix.
		 * @param	matrix - Объект Matrix, из которого следует скопировать данные.
		 */
		public function submit(matrix:Matrix):void
		{
			matrix.a = a;
			matrix.b = b;
			matrix.c = c;
			matrix.d = d;
			matrix.tx = tx;
			matrix.ty = ty;
		}
		/**
		 * Возвращает новый объект rcMatrix, который является клоном данной матрицы с точной копией содержащегося в ней объекта.
		 * @return Объект rcMatrix.
		 */
		public function clone():rcMatrix
		{
			return get(a, b, c, d, tx, ty);
		}
		/**
		 * Совершает проверку матрыцы на отличие от стандартного ее вида (исключая значения перемещения tx и ty). Можно использовать для определения необходимости трансформации отображаемого объекта.
		 * @return true - если матрица не изменялась.
		 */
		public function isElementary():Boolean
		{
			if (a == 1 && 
				b == 0 &&
				c == 0 &&
				d == 1)
			{
				return true;
			}
			return false;
		}
		/**
		 * Совершает проверку матрыцы на отличие от стандартного ее вида (исключая значения перемещения tx и ty, и применение поворота). Можно использовать для определения необходимости масштабирования отображаемого объекта.
		 * @return
		 */
		public function isUniform():Boolean
		{
			return a == d && b == -c;
		}
		/** Кеширует матрицу для ее дальнейшего использования. Используя данный метод в связке со статическим методом get можно обойти необходимость вызова конструкторов, что ускорит работу приложения. */
		public function dispose():void
		{
			pool.push(this);
		}
		
		private static var pool:Vector.<rcMatrix> = new Vector.<rcMatrix>();
		/**
		 * Возвращает кешированую матрицу. Если в кеше нет матриц - создается новая. Например: myMatrix = new rcMatrix(), можно заменить на myMatrix = rcMatrix.get(), а при отсутсвии необходимости ее дальнейшего использования myMatrix.dispose(); myMatrix = null;
		 * @param	a - значения, которые можно задать для матрицы.
		 * @param	b
		 * @param	c
		 * @param	d
		 * @param	tx
		 * @param	ty
		 * @return  объект rcMatrix
		 */
		public static function get(a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0):rcMatrix
		{
			var m:rcMatrix;
			if (pool.length) 
			{
				m = pool.pop();
				m.edit(a, b, c, d, tx, ty);
				return m;
			}
			return new rcMatrix(a, b, c, d, tx, ty);
		}
		
	}

}