Try the first module example:

%Emporium.Module{name: "mod_hello", is_active: true} |> EmporiumApi.Repo.insert!

open localhost:4000/hello