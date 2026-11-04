package automation.framework.beans;

  /**
     * Data Transfer Object for storing field validation results
     * Used to encapsulate validation outcomes for HTML reporting
     */
  public class FieldValidationResult {
        private String fieldName;
        private String xpath;
        private boolean editableValid;
        private boolean requiredValid;
        private String backgroundColor;

        // Getters and setters
        public String getFieldName() {
            return fieldName;
        }

        public void setFieldName(String fieldName) {
            this.fieldName = fieldName;
        }

        public String getXpath() {
            return xpath;
        }

        public void setXpath(String xpath) {
            this.xpath = xpath;
        }

        public boolean isEditableValid() {
            return editableValid;
        }

        public void setEditableValid(boolean editableValid) {
            this.editableValid = editableValid;
        }

        public boolean isRequiredValid() {
            return requiredValid;
        }

        public void setRequiredValid(boolean requiredValid) {
            this.requiredValid = requiredValid;
        }

        public String getBackgroundColor() {
            return backgroundColor;
        }

        public void setBackgroundColor(String backgroundColor) {
            this.backgroundColor = backgroundColor;
        }
    }