/// @function approach(a, b, amount)
function approach(_a,_b,_amount) {
	if (_a < _b) {
		_a += _amount;
		if (_a > _b) return _b;
	}
	else {
		_a -= _amount;
		if (_a < _b) return _b;
	}
	return _a;
}

function line_get_slope(_x1,_y1,_x2,_y2) {
	if (_x1 == _x2) return 0;
	return (_y2-_y1)/(_x2-_x1);
}