package bitrise.core.data
{
	import bitrise.core.reflection.Clazz;
	import bitrise.core.reflection.Reflection;
	import bitrise.core.reflection.fields.Variable;
	
	import flash.display.DisplayObjectContainer;

	public class DataContainer extends Data
	{
		
		internal const _childrens:Vector.<Data> = new Vector.<Data>();
		
		public function DataContainer() {
			super();
		}
		
		public function addChild(child:Data):Data {
			if (!child)
				throw new ArgumentError();
			if (child._parent)
				throw new ArgumentError();
			
			_childrens.push(child);
			child._parent = this;
			child.$main = $main;
			
			if (super.hasEventListener(DataEvent.ADDED))
				super.dispatchEvent(new DataEvent(DataEvent.ADDED, [child]));
			
			return child;
		}
		
		public function addChildAt(child:Data, index:int):Data {
			if (!child)
				throw new ArgumentError();
			if (child._parent)
				throw new ArgumentError();
			checkRange(index);
			
			_childrens.splice(index, 0, child);
			child._parent = this;
			child.$main = $main;
			
			if (super.hasEventListener(DataEvent.ADDED))
				super.dispatchEvent(new DataEvent(DataEvent.ADDED, [child]));
			
			return child;
		}
		
		public function removeChild(child:Data):Data {
			if (!child)
				throw new ArgumentError();
			if (child._parent != this)
				throw new ArgumentError();
			
			_childrens.splice(_childrens.indexOf(child), 1);
			child._parent = null;
			child.$main = null;
			
			if (super.hasEventListener(DataEvent.REMOVED))
				super.dispatchEvent(new DataEvent(DataEvent.REMOVED, [child]));
			
			return child;
		}
		
		public function removeChildAt(index:int):Data {
			checkRange(index);
			
			const child:Data = _childrens[index];
			_childrens.splice(index, 1);
			child._parent = null;
			child.$main = null;
			
			if (super.hasEventListener(DataEvent.REMOVED))
				super.dispatchEvent(new DataEvent(DataEvent.REMOVED, [child]));
			
			return child;
		}
		
		public function swapChildren(child1:Data, child2:Data):void {
			if (!child1 || !child2)
				throw new ArgumentError();
			if (child1._parent != this || child2._parent != this)
				throw new ArgumentError();
			
			const index1:int = _childrens.indexOf(child1);
			const index2:int = _childrens.indexOf(child2);
			
			_childrens.splice(index1, 1, child2);
			_childrens.splice(index2, 1, child1);
			
			if (super.hasEventListener(DataEvent.SWAPPED))
				super.dispatchEvent(new DataEvent(DataEvent.SWAPPED, [child1, child2]));
			
		}
		
		public function swapChildrenAt(index1:int, index2:int):void {
			checkRange(index1);
			checkRange(index2);
			
			const child1:Data = _childrens[index1];
			const child2:Data = _childrens[index2];
			
			_childrens.splice(index1, 1, child2);
			_childrens.splice(index2, 1, child1);
			
			if (super.hasEventListener(DataEvent.SWAPPED))
				super.dispatchEvent(new DataEvent(DataEvent.SWAPPED, [child1, child2]));
		}
		
		public function getChildAt(index:int):Data {
			checkRange(index);
			return _childrens[index];
		}
		
		public function getChildIndex(child:Data):int {
			if (!child)
				return -1;
			if (child._parent)
				return -1;
			return _childrens.indexOf(child);
		}
		
		public function getChildByName(name:String):Data {
			for each(var child:Data in _childrens) {
				if (child.name == name)
					return child;
			}
			return null;
		}
		
		public function get numChildren():uint {
			return _childrens.length;
		}
		
		private function checkRange(index:int):void {
			if (index < 0 || index > _childrens.length - 1)
				throw new RangeError();
		}
		
		override internal function set $main(value:MainData):void {
			super.$main = value;
			for each(var data:Data in _childrens) {
				data.$main = value;
			}
		}
	}
}