ActiveAdmin.register Team do
  form do |f|
    f.inputs do
      f.input :location
      f.input :name
      f.input :abbr
      f.input :league
      f.input :conference
      f.input :division
    end
  end
end
