class_name Trail3D extends MeshInstance3D

var _points = []
var _widths = []
var _lifePoints = []

@export var _trailEnabled : bool = true

@export var _from : float = 1.0
@export var _to : float = 0.0
@export_range(0.5, 1.5) var _scaleAcceleration : float = 1.0

@export var _motionDelta : float = 0.1
@export var _lifespan : float = 1.0

@export var _startColor : Color = Color(1,1,1,1)
@export var _endColor : Color = Color(1,1,1,0)

var _oldPos : Vector3

func _ready():
	_oldPos = global_position
	mesh = ImmediateMesh.new()
	
func AppendPoint():
	
	_points.append(global_position)
	_widths.append([
		get_parent().basis.x * _from,
		get_parent().basis.x * _from - get_parent().basis.x * _to
	])
	_lifePoints.append(0.0)
	
func RemovePoint(i):
	_points.remove_at(i)
	_widths.remove_at(i)
	_lifePoints.remove_at(i)


func _process(delta):
	if (_oldPos - global_position).length() > _motionDelta and _trailEnabled:
		AppendPoint()
		_oldPos = global_position
		
		var p = 0
		var max_points = _points.size()
		while p<max_points:
			_lifePoints[p] += delta
			if _lifePoints[p] > _lifespan:
				RemovePoint(p)
				p-=1
				if (p<0):p=0
			max_points = _points.size()
			p+=1
		
		mesh.clear_surfaces()
		
		if _points.size() < 2:
			return

		var st : SurfaceTool = SurfaceTool.new() 
		st.begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
		for i in range (_points.size()):
			var t = float(i) / (_points.size()-1.0)
			var currColor = _startColor.lerp(_endColor, 1-t)
			st.set_color(currColor)
			
			var currWidth = _widths[i][0] - pow(1-t, _scaleAcceleration) * _widths[i][1]
			var t0 = i/ _points.size()
			var t1 = t
			
			st.set_uv(Vector2(t0,0))
			st.add_vertex(to_local(_points[i] + currWidth))
			st.set_uv(Vector2(t1,1))
			st.add_vertex(to_local(_points[i] - currWidth))
		mesh = st.commit()
		
