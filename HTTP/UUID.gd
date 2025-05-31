static func get_random_int(max_value: int) -> int:
	randomize()
	return randi() % max_value

static func random_bytes(n: int) -> Array:
	var r: Array = []
	for index: int in range(0, n):
		r.append(get_random_int(256))
	return r

static func uuid_bin() -> Array:
	var b: Array = random_bytes(16)
	b[6] = (b[6] & 0x0f) | 0x40
	b[8] = (b[8] & 0x3f) | 0x80
	return b

static func generate_uuid_v4() -> String:
	var b: Array = uuid_bin()
	var low: String = "%02x%02x%02x%02x" % [b[0], b[1], b[2], b[3]]
	var mid: String = "%02x%02x" % [b[4], b[5]]
	var hi: String = "%02x%02x" % [b[6], b[7]]
	var clock: String = "%02x%02x" % [b[8], b[9]]
	var node: String = "%02x%02x%02x%02x%02x%02x" % [b[10], b[11], b[12], b[13], b[14], b[15]]
	return "%s-%s-%s-%s-%s" % [low, mid, hi, clock, node]

static func is_uuid(test_string: String) -> bool:
	return test_string.count("-") == 4 and test_string.length() == 36
