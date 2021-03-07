group "app" do
  gid 505
end

include_recipe "./app"

# group "wheel" do
#   # members ["app"]
#   user "app"
# end
