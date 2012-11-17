module ApplicationHelper
  def seconds_in_hh_mm_ss(seconds)
    mm, ss = seconds.divmod(60)
    hh, mm = mm.divmod(60)
    ss = ss < 10 ? "0#{ss}" : ss
    mm = mm < 10 ? "0#{mm}" : mm
    hh = hh < 10 ? "0#{hh}" : hh
    "#{hh}:#{mm}:#{ss}"
  end
end
