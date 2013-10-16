module Emitter

  def on(name, &block)
    callbacks[name] << block
    self
  end

  def emit(name, *args)
    callbacks[name].each do |blks|
      blks.call(*args)
    end
    self
  end

  private

  def callbacks
    @callbacks ||= Hash.new { |h,k| h[k] = [] }
  end

end