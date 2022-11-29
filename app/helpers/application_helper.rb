module ApplicationHelper
  def title(title)
    content_for :title, title.to_s
  end
  

  def filter_1
    if params[:type] == 'scholier'
      "Middelbare school"
    else 
      "Universiteit/Hogeschool"
    end
  end

  def filter_2
    if params[:type] == 'scholier' 
      "Niveau"
    elsif params[:type] == 'student'
      "Faculteit"
    else
      unless @institute.blank? 
        if  @institute.level == 'MS'
          "Niveau"
        else
          "Faculteit"
        end
      end
    end
  end

  def filter_3
    if params[:type] == 'scholier' 
      "Jaar"
    elsif params[:type] == 'student'
      "Opleiding"
    else
      unless @institute.blank? 
        if  @institute.level == 'MS'
          "Jaar"
        else
          "Opleiding"
        end
      end
    end
  end

  def filter_4
    "Vak"
  end

end

