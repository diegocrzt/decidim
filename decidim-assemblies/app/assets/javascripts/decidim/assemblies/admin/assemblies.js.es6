$(() => {
  ((exports) => {
    const $assemblyScopeEnabled = $('#assembly_scopes_enabled');
    const $assemblyScopeId = $("#assembly_scope_id");

    if ($('.edit_assembly, .new_assembly').length > 0) {
      $assemblyScopeEnabled.on('change', (event) => {
        const checked = event.target.checked;
        exports.theDataPicker.enabled($assemblyScopeId, checked);
      })
      exports.theDataPicker.enabled($assemblyScopeId, $assemblyScopeEnabled.prop('checked'));
    }


    const $form = $('.assembly_form_admin');

    if ($form.length > 0) {

      const $isOpen = $form.find('#is_open');
      const $isPublic = $form.find('#is_public');
      const $isTransparent = $form.find('#is_transparent');
      const $specialFeatures = $form.find('#special_features');


      const toggleDisabledHiddenFields = () => {
        const enabledIsOpen = $isOpen.find('input[type="checkbox"]').prop('checked');
        const enabledIsPublic = $isPublic.find('input[type="checkbox"]').prop('checked');

        $isPublic.hide();
        $isTransparent.hide();
        $specialFeatures.hide();

        if (!enabledIsOpen) {
          $isPublic.find('input[type="checkbox"]').attr('disabled', enabledIsOpen);
          $isPublic.show();
          $specialFeatures.show();

          if (!enabledIsPublic) {
            $isTransparent.find('input[type="checkbox"]').attr('disabled', enabledIsPublic);
            $isTransparent.show();
          }
        }
      };
      $isOpen.on('change', toggleDisabledHiddenFields);
      $isPublic.on('change', toggleDisabledHiddenFields);
      toggleDisabledHiddenFields();



      const $assemblyType = $form.find('#assembly_assembly_type');
      const $assemblyTypeOther = $form.find('#assembly_type_other');

      const toggleDependsOnSelect = (this) => {
        alert("You Clicked a!");

        if($(this).val() === 'others'){
          alert("You Clicked a!");
        }
      };
      $assemblyType.on('change', toggleDependsOnSelect);

    }

  })(window);
});
