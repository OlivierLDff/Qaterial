#ifndef __QATERIAL_FOLDER_TREE_MODEL_HPP__
#define __QATERIAL_FOLDER_TREE_MODEL_HPP__

// ──── INCLUDE ────

// Library Headers
#include <Qaterial/Export.hpp>
#include <Qaterial/Property.hpp>

// Dependencies Headers
#include <QOlm/QOlm.hpp>
#include <QObject>
#include <QString>
#include <QDateTime>

// Standard Header

// ──── DECLARATION ────

namespace qaterial {

// ──── CLASS ────

// FolderListModel provides access to information about the contents of a folder in the local file system,
// exposing a list of files to views and other data components.
class QATERIAL_API_ FolderTreeModel : public qolm::QOlm<FolderTreeModel>
{
    Q_OBJECT
    QATERIAL_REGISTER_TO_QML(FolderTreeModel)

public:
    FolderTreeModel(QObject* parent = nullptr);

private:
    FolderTreeModel(const QUrl& path,
        const QString& fileName,
        const QString& filePath,
        const QString& fileBaseName,
        const QString& fileCompleteBaseName,
        const QString& fileSuffix,
        const QString& fileCompleteSuffix,
        qint64 fileSize,
        const QDateTime& fileModified,
        const QDateTime& fileAccessed,
        bool fileIsDir,
        QObject* parent = nullptr);
    void initializeBindings();

public:
    enum Status
    {
        Null, // no folder has been set
        Ready, // the folder has been loaded
        Loading // the folder is currently being loaded
    };
    Q_ENUM(Status);

    enum SortField
    {
        Unsorted, // no sorting is applied
        Name, // sort by filename
        Time, // sort by time modified
        Size, // sort by file size
        Type // sort by file type(extension)
    };
    Q_ENUM(SortField);

protected:
    Q_PROPERTY(FolderTreeModel* children READ children CONSTANT);

public:
    FolderTreeModel* children();

protected:
    QATERIAL_PROPERTY(bool, expanded, Expanded);

    // The path property holds a URL for the folder that the model currently provides.
protected:
    Q_PROPERTY(QUrl path READ path WRITE setPath NOTIFY pathChanged RESET resetPath)
private:
    QUrl _path = {};

public:
    QUrl path() const;
    virtual bool setPath(const QUrl& value);
    void resetPath();

Q_SIGNALS:
    void pathChanged(QUrl path);

private:
    // The nameFilters property contains a list of file name filters. The filters may include the ? and * wildcards.
    // The example below filters on PNG and JPEG files :
    // ```js
    // FolderTreeModel { nameFilters: ["*.png", "*.jpg"] }
    // ```
    QATERIAL_PROPERTY(QStringList, nameFilters, NameFilters);
    // Use case sensitive pattern matching.
    // By default, this property is true.
    QATERIAL_PROPERTY(bool, caseSensitive, CaseSensitive);

    // If true, drives are included in the model.
    QATERIAL_PROPERTY_D(bool, showDrives, ShowDrives, true);
    // If true, directories are included in the model; otherwise only files are included.
    QATERIAL_PROPERTY_D(bool, showDirs, ShowDirs, true);
    // If true, files are included in the model; otherwise only directories are included.
    QATERIAL_PROPERTY_D(bool, showFiles, ShowFiles, true);
    // If true, if directories are included in the model they will always be shown first, then the files.
    QATERIAL_PROPERTY_D(bool, showDirsFirst, ShowDirsFirst, true);
    // If true, the "." directory is included in the model; otherwise it is excluded.
    QATERIAL_PROPERTY(bool, showDot, ShowDot);
    // If true, the ".." directory is included in the model; otherwise it is excluded.
    QATERIAL_PROPERTY(bool, showDotDot, ShowDotDot);
    // If true, the "." and ".." directories are included in the model; otherwise they are excluded.
    QATERIAL_PROPERTY(bool, showDotAndDotDot, ShowDotAndDotDot);
    // If true, hidden files and directories are included in the model; otherwise they are excluded.
    QATERIAL_PROPERTY(bool, showHidden, ShowHidden);
    // If true, only readable files and directories are shown; otherwise all files and directories are shown.
    QATERIAL_PROPERTY(bool, showOnlyReadable, ShowOnlyReadable);

    // If set to true, the sort is case sensitive. This property is true by default.
    QATERIAL_PROPERTY_D(bool, sortCaseSensitive, SortCaseSensitive, true);
    // If set to true, reverses the sort order. The default is false.
    QATERIAL_PROPERTY(bool, sortReversed, SortReversed);
    // The sortField property contains field to use for sorting. sortField may be one of:
    // - FolderTreeModel.Unsorted
    // - FolderTreeModel.Name
    // - FolderTreeModel.Time
    // - FolderTreeModel.Size
    // - FolderTreeModel.Type
    QATERIAL_PROPERTY_D(int, sortField, SortField, SortField::Unsorted);

    // This property holds the status of folder reading. It can be one of:
    // - FolderTreeModel.Null - no folder has been set
    // - FolderTreeModel.Ready - the folder has been loaded
    // - FolderTreeModel.Loading - the folder is currently being loaded
    QATERIAL_PROPERTY_RO_D(int, status, Status, Status::Null);

    // Returns the name of the file, excluding the path.
    QATERIAL_PROPERTY_RO(QString, fileName, FileName);

    // Returns the file name, including the path (which is absolute).
    QATERIAL_PROPERTY_RO(QString, filePath, FilePath);

    // Returns the base name of the file without the path.
    // The base name consists of all characters in the file up to (but not including) the first '.' character.
    // Example : "/tmp/archive.tar.gz" baseName is "archive"
    // The base name of a file is computed equally on all platforms, independent of file naming conventions (e.g., ".bashrc" on Unix has an empty base name, and the suffix is "bashrc").
    QATERIAL_PROPERTY_RO(QString, fileBaseName, FileBaseName);

    // Returns the complete base name of the file without the path.
    // The complete base name consists of all characters in the file up to (but not including) the last '.' character.
    // Example : "/tmp/archive.tar.gz" baseName is "archive.tar"
    QATERIAL_PROPERTY_RO(QString, fileCompleteBaseName, FileCompleteBaseName);

    // Returns the suffix (extension) of the file.
    // The suffix consists of all characters in the file after (but not including) the last '.'.
    // Example : "/tmp/archive.tar.gz" return "gz"
    // The suffix of a file is computed equally on all platforms, independent of file naming conventions (e.g., ".bashrc" on Unix has an empty base name, and the suffix is "bashrc").
    QATERIAL_PROPERTY_RO(QString, fileSuffix, FileSuffix);

    // Returns the complete suffix (extension) of the file.
    // The complete suffix consists of all characters in the file after(but not including) the first '.'.
    // Example : "/tmp/archive.tar.gz" return "tar.gz"
    QATERIAL_PROPERTY_RO(QString, fileCompleteSuffix, FileCompleteSuffix);

    // Returns the file size in bytes. If the file does not exist or cannot be fetched, 0 is returned.
    // If the file is a symlink, the size of the target file is returned (not the symlink).
    QATERIAL_PROPERTY_RO(qint64, fileSize, FileSize);

    // Returns the date and local time when the file was last modified.
    // If the file is a symlink, the time of the target file is returned (not the symlink).
    QATERIAL_PROPERTY_RO(QDateTime, fileModified, FileModified);
    Q_PROPERTY(QDateTime lastModified READ fileModified NOTIFY fileModifiedChanged);

    // Returns the date and local time when the file was last read (accessed).
    // On platforms where this information is not available, returns the same as fileModified().
    // If the file is a symlink, the time of the target file is returned (not the symlink).
    QATERIAL_PROPERTY_RO(QDateTime, fileAccessed, FileAccessed);
    Q_PROPERTY(QDateTime lastRead READ fileAccessed NOTIFY fileAccessedChanged);

    // Returns true if this object points to a directory or to a symbolic link to a directory; otherwise returns false.
    // If the file is a symlink, this function returns true if the target is a directory (not the symlink).
    QATERIAL_PROPERTY_RO(bool, fileIsDir, FileIsDir);
    Q_PROPERTY(bool isDir READ fileIsDir NOTIFY fileIsDirChanged);

public Q_SLOTS:
    void fetch();

private:
    // mutex that avoid binding loop between showDot showDotDot showDotAndDotDot
    bool _dotEvaluation = false;
};

}

#endif
