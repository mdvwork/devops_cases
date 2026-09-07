from app.main import calculate_health_score


def test_score_in_range():
    assert calculate_health_score(75) == 75


def test_score_has_upper_limit():
    assert calculate_health_score(150) == 100


def test_score_has_lower_limit():
    assert calculate_health_score(-10) == 0
