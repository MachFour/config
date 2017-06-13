push!(LOAD_PATH, "/home/max/")

# for macros calculation
function energies(protein, fat, carbs)
	e = [protein, fat, carbs].*[17, 37, 17]
	100*e/sum(e)
end

function calc_c(f, l)
	c = 1/(2*pi*f*sqrt(l))^2
end

function calc_f(l, c)
	f = 1/(2*pi*sqrt(l*c))
end

function calc_l(f, c)
	l = 1/(2*pi*f*sqrt(c))^2
end
