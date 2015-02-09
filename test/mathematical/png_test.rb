require "test_helper"

class Mathematical::PNGTest < Test::Unit::TestCase
  def before
    File.delete("#{fixtures_dir}/png/pmatrix.png") if File.exist?("#{fixtures_dir}/png/pmatrix.png")
  end

  def test_it_creates_a_png
    string = '''
    $$
\begin{pmatrix}
     1 & a_1 & a_1^2 & \cdots & a_1^n \\\\
     1 & a_2 & a_2^2 & \cdots & a_2^n \\\\
     \vdots  & \vdots& \vdots & \ddots & \vdots \\\\
     1 & a_m & a_m^2 & \cdots & a_m^n
     \end{pmatrix}
$$
'''
    render = Mathematical.new({:format => :png})
    data_hash = render.render(string)
    header = data_hash['png'].unpack('H*').first.slice(0, 18)
    File.open("#{fixtures_dir}/png/pmatrix.png", 'w') { |f| f.write(data_hash['png'])}
    assert_equal header, '89504e470d0a1a0a00'
  end
end
