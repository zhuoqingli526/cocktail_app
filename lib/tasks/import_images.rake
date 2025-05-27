# lib/tasks/import_images.rake

namespace :import do
  desc "Fill existing Cocktail records with image_url using local image files"
  task fill_cocktail_images: :environment do
    # Set the directory where your cocktail images are stored
    images_dir = Rails.root.join("app/assets/images")

    puts "📂 Scanning image directory: #{images_dir}"

    # Step 1: Build a hash to map normalized file names => full file path
    # Example: "scarletfizz" => "/full/path/Scarlet Fizz.png"
    all_image_files = Dir.glob("#{images_dir}/*.{png,jpg,jpeg}").to_h do |path|
      normalized = File.basename(path, ".*").downcase.gsub(/\s+/, "")
      [normalized, path]
    end

    # Step 2: Iterate through each cocktail record
    Cocktail.find_each do |cocktail|
      # Normalize the cocktail name: remove spaces and lowercase
      normalized_name = cocktail.cocktail_name.to_s.downcase.gsub(/\s+/, "")

      # Try to find a matching image file using the normalized name
      file_path = all_image_files[normalized_name]

      unless file_path
        puts "❌ Image not found for ##{cocktail.id} #{cocktail.cocktail_name}"
        next
      end

      # Step 3: Assign the file to the uploader-mapped field
      cocktail.image_url = File.open(file_path)

      if cocktail.save
        puts "✅ Updated ##{cocktail.id} #{cocktail.cocktail_name}"
      else
        puts "❌ Failed to save ##{cocktail.id}: #{cocktail.errors.full_messages.join(', ')}"
      end
    end

    puts "🎉 All cocktail records have been processed."
  end
end
