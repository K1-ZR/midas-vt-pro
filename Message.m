function MessageHandle = Message( Index, Text )


if Index==1
elseif Index==21
    msgbox({'The selected mixture is unavailable.';
        'Please select other options.'});
    
elseif Index==31
    msgbox({'The selected test type is unavailable.';
        'Please select other options.'});
end

end



