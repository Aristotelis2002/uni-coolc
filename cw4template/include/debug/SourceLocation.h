#ifndef DEBUG_SOURCE_LOCATION_H_
#define DEBUG_SOURCE_LOCATION_H_

#include <ostream>

class SourceLocation {
  private:
    const unsigned long line_;
    const unsigned long column_;
    const bool is_valid_;

  private:
    SourceLocation() : line_(0), column_(0), is_valid_(false) {}

  public:
    SourceLocation(unsigned long line, unsigned long column)
        : line_(line), column_(column), is_valid_(true) {}

    static SourceLocation invalid() { return SourceLocation{}; }

    unsigned long get_line() const { return line_; }
    unsigned long get_column() const { return column_; }
    bool is_valid() const { return is_valid_; }

    bool operator==(const SourceLocation &other) const {
        if (!this->is_valid_ && !other.is_valid_)
            return true;
        return this->line_ == other.line_ && this->column_ == other.column_;
    }
};

std::ostream &operator<<(std::ostream &out,
                         const SourceLocation &source_location);

#endif