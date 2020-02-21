def progress_bar_today
  unless UserSetting.find_by(user_id: session[:user]).nil?
    @user_setting = UserSetting.find_by(user_id: session[:user])
    if current_user.pomodoros.nil?
      @percent = 0
    else
      if current_user.pomodoros.find_by('created_at >= ?', Date.today.in_time_zone('Tokyo')).nil?
        @pomodoro = 0
      else
        @pomodoro = current_user.pomodoros.where('created_at >= ?', Date.today.in_time_zone('Tokyo')).sum(:time)
      end
      @percent = (@pomodoro.to_d / 3600 / @user_setting.goal.to_d * 100).floor(2).to_f
      @study_summary = "#{(@pomodoro.to_d / 3600).floor(2).to_f}""時間/""#{@user_setting.goal}""時間"
    end
    if @percent > 100
      @percent == 100
    end
  end
end

def progress_bar_week
  unless UserSetting.find_by(user_id: session[:user]).nil?
    @user_setting_week = UserSetting.find_by(user_id: session[:user])
    if current_user.pomodoros.nil?
      @percent_week = 0
    else
      if current_user.pomodoros.find_by('created_at >= ?', 1.week.ago.in_time_zone('Tokyo')).nil?
        @pomodoro_week = 0
      else
        @pomodoro_week = current_user.pomodoros.where('created_at >= ?', 1.week.ago.in_time_zone('Tokyo')).sum(:time)
      end
      @percent_week = (@pomodoro_week.to_d / 3600 / @user_setting_week.goal.to_d / 7 * 100).floor(2).to_f
      @study_summary_week = "#{(@pomodoro_week.to_d / 3600).floor(2).to_f}""時間/""#{@user_setting_week.goal * 7}""時間"
    end
    if @percent_week > 100
      @percent_week == 100
    end
  end
end