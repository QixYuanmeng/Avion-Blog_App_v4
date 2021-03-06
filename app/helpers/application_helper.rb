module ApplicationHelper

  def toastr_flash
    
    flash.each_with_object([]) do |(type, message), flash_messages|
      
      type = 'success' if type == 'notice'
      type = 'error' if type == 'alert'
      title = 'Hooray!' if type == 'notice'
      title = 'Oh snap!' if type == 'alert'

      # multi-line string has returns '\n', used squish to remove it
      text = "<script>
        toastr.#{type}(\"#{message}\", '#{title}', { 
            closeButton: true, 
            progressBar: true,
            positionClass: 'toast-top-center'
          })
      </script>".squish

      flash_messages << text.html_safe if message
      flash_messages.join("\n")
    end
  end


  def parse_errors(errors)
    hash = Hash.new

    errors.each do |err|
      hash[err.attribute.to_s.upcase] = err.message
    end

    hash
  end

end
